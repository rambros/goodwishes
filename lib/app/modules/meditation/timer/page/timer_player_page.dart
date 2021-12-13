import 'dart:async';
import 'dart:convert';
import 'package:audio_session/audio_session.dart';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../statistics/model/meditation_log.dart';
import '../../statistics/repository/med_statistics_repository.dart';
import '../../timer/model/timer_model.dart';
import './../../../../shared/services/analytics_service.dart';
import './../../../../shared/utils/ui_utils.dart';

import '../controller/timer_player_controller.dart';

class TimerPlayerPage extends StatefulWidget {
  final TimerModel? timerModel;
  TimerPlayerPage({this.timerModel});

  @override
  State<StatefulWidget> createState() => TimerPlayerPageState();
}

class TimerPlayerPageState extends ModularState<TimerPlayerPage, TimerPlayerController> 
      with WidgetsBindingObserver {
  int? totaltime, sessioncompleted, averageduration;

  late AudioPlayer _player;    
  late ConcatenatingAudioSource _playlist;

  bool paused = false;

  Stopwatch watch = Stopwatch();
  Timer? timer;
  String elapsedTime = '00:00';
  int? timeRemaining = 0;
  Timer? _timer;
  String? timerState;

  late SharedPreferences prefs;
  String timerKey = 'runningTimer';
  
  final _chartSize = const Size(300.0, 300.0);
  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();

  @override
  void initState() {
    super.initState();
    //checkConnectivity();
    WidgetsBinding.instance!.addObserver(this);

    timeRemaining = widget.timerModel!.duration;
    elapsedTime = updateChartTime(timeRemaining!*1000);
    
    _saveTimerToPrefs();

    _player = AudioPlayer();
    _initSession();
  }

  void _initSession() async {

    createPlaylist();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print('An error occured $e');
    }
  }

  void createPlaylist() {
    var listAudios = <AudioSource>[];
    int? durationStartSound = 0;

    if (widget.timerModel!.soundStartPath!.isNotEmpty) {
      listAudios.add(AudioSource.uri(
          Uri.parse('asset:///assets/' + widget.timerModel!.soundStartPath!),));
      durationStartSound = widget.timerModel!.soundStartDuration;    
    }

    var timeForLoop = widget.timerModel!.duration! - durationStartSound!;
    while (timeForLoop > widget.timerModel!.soundBackgroundDuration!) {
      listAudios.add(AudioSource.uri(
          Uri.parse('asset:///assets/' + widget.timerModel!.soundBackgroundLocation!),));
      timeForLoop = timeForLoop - widget.timerModel!.soundBackgroundDuration!;    
    }
    if ( timeForLoop > 0) {
      listAudios.add(ClippingAudioSource(
        start: Duration(seconds: 0),
        end: Duration(seconds: timeForLoop),
        child: AudioSource.uri(Uri.parse(
            'asset:///assets/' + widget.timerModel!.soundBackgroundLocation!)),
      ));
    }

    if (widget.timerModel!.soundEndPath!.isNotEmpty) {
      listAudios.add(AudioSource.uri(
          Uri.parse('asset:///assets/' + widget.timerModel!.soundEndPath!),));
    }

    _playlist = ConcatenatingAudioSource(children: listAudios,);
     
    // [
    // startSound 
    // AudioSource.uri(
    //   Uri.parse('asset:///assets/sounds/gongo/gongo.mp3'),
    // ),
    // background
    // LoopingAudioSource(
    //   count: 3,
    //   child:  AudioSource.uri(Uri.parse(
    //                    'asset:///assets/sounds/background/vento.mp3'),
    //   ),
    // ),
    // extra clip if necessary
    // LoopingAudioSource(
    //   count: 2,
    //   child: ClippingAudioSource(
    //     start: Duration(seconds: 15),
    //     end: Duration(seconds: 30),
    //     child: AudioSource.uri(Uri.parse(
    //         'asset:///assets/sounds/background/silencio.mp3')),
    //   ),
    // ),
    // end sound
    // AudioSource.uri(
    //   Uri.parse(
    //       'asset:///assets/sounds/gongo/kshanti.mp3'),
    // ),
    //]
  }

  Future<bool> _saveTimerToPrefs() async {
    prefs = await SharedPreferences.getInstance();
    var tms = {
      'time_remaining': timeRemaining,
      'started_at': DateTime.now().millisecondsSinceEpoch,
    };
    return await prefs.setString(timerKey, json.encode(tms));
  }

  void _loadTimerFromPrefs() {
    var tm = prefs.getString(timerKey);
    if (tm == null) return;
    Map<String, dynamic> tms = json.decode(tm);
    var startedAt = DateTime.fromMillisecondsSinceEpoch(tms['started_at']);
    int _timeRemaining = tms['time_remaining'];

    print(DateTime.now());
    print(startedAt);
    print('difference: ' + DateTime.now().difference(startedAt).inSeconds.toString());
    print('time remaining: ' + _timeRemaining.toString());

    var elapsedTime = DateTime.now().difference(startedAt).inSeconds;
    if (elapsedTime < _timeRemaining) {
      timeRemaining = _timeRemaining - elapsedTime;
    } else {
        timeRemaining = 0;
    }
  }

  void _clearTimerFromPrefs() async {
    await prefs.remove(timerKey);
  }

  @override
  void dispose() {
    onDispose();
    WidgetsBinding.instance!.removeObserver(this);
    _clearTimerFromPrefs();
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print('Inactive');
        break;
      case AppLifecycleState.paused:
        print('Paused');
        break;
      case AppLifecycleState.resumed:
        print('Resumed');
        _loadTimerFromPrefs();
        break;
      case AppLifecycleState.detached:
        print('Detached');
        break;
    }
  }

  List<CircularStackEntry> _generateChartData(int minute, int second) {
    /// Check the graph position
    var data = <CircularStackEntry>[
      CircularStackEntry([
        CircularSegmentEntry(
          second.toDouble(),
          Colors.blue,
          rankKey: 'completado',
        ),
        CircularSegmentEntry(
          widget.timerModel!.duration! - second.toDouble(),
          Colors.white,
          rankKey: 'restando',
        )
      ])
    ];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 50),
        child: Padding(
          padding: const EdgeInsets.only(top: 130.0),
          child: FloatingActionButton(
            elevation: 10,
            backgroundColor: Colors.white,
            onPressed: onDispose,
            child: BackButton(
              color: Colors.black,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black, //Theme.of(context).accentColor,
          ),
          Positioned(
              top: 100,
              left: 0,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    widget.timerModel!.title ?? 'Meditação com Timer',
                    style:
                        TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.22,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedCentralClock(
                                 chartKey: _chartKey,
                                 chartSize: _chartSize,
                                 label: elapsedTime != null 
                                 ? '$elapsedTime'
                                 : initialDuration(widget.timerModel!.duration!)
                      ),
                      //monta relogio central
                      // StreamBuilder<Duration>(
                      //   stream: _audioPlayerBGSound.durationStream,
                      //   builder: (context, snapshot) {
                      //     final duration = snapshot.data ?? Duration.zero;
                      //     return StreamBuilder<Duration>(
                      //       stream: _audioPlayerBGSound.getPositionStream(),
                      //       builder: (context, snapshot) {
                      //         var position = snapshot.data ?? Duration.zero;
                      //         if (position > duration) {
                      //           position = duration;
                      //         }
                      //         //Duration timeRemaining = duration - position;
                      //         //elapsedTime = updateChartTime(timeRemaining.inMilliseconds);
                      //         elapsedTime = updateChartTime(position.inMilliseconds) ??
                      //             transformMilliseconds(duration.inMilliseconds);
                      //         return AnimatedCentralClock(
                      //           chartKey: _chartKey,
                      //           chartSize: _chartSize,
                      //           label: '$elapsedTime',
                      //         );
                      //       },
                      //     );
                      //   },
                      // ),

                      // botoes de controle
                      // Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         if (watch.isRunning)
                      //          IconButton(
                      //             icon: Icon(Icons.pause),
                      //             iconSize: 86.0,
                      //             color: Colors.white,
                      //             onPressed: _onPause,
                      //           )
                      //         else if (timeRemaining > 0)
                      //            IconButton(
                      //             icon: Icon(Icons.play_arrow),
                      //             iconSize: 86.0,
                      //             color: Colors.white,
                      //             onPressed: _onPlay,
                      //           ) else 
                      //           Container(
                      //             child: Text(
                      //               'Concluído',
                      //               style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),),
                      //           ),
                      //       ],
                      // ),
                      //verticalSpace(16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // IconButton(
                          //   icon: Icon(Icons.volume_up),
                          //   onPressed: () {
                          //     _showSliderDialog(
                          //       context: context,
                          //       title: 'Ajustar volume',
                          //       divisions: 10,
                          //       min: 0.0,
                          //       max: 1.0,
                          //       stream: _player.volumeStream,
                          //       onChanged: _player.setVolume,
                          //     );
                          //   },
                          // ),

                          StreamBuilder<PlayerState>(
                            stream: _player.playerStateStream,
                            builder: (context, snapshot) {
                              final playerState = snapshot.data;
                              final processingState = playerState?.processingState;
                              final playing = playerState?.playing;
                              if (processingState == ProcessingState.loading ||
                                  processingState == ProcessingState.buffering) {
                                return Container(
                                  margin: EdgeInsets.all(8.0),
                                  width: 86.0,
                                  height: 86.0,
                                  child: CircularProgressIndicator(),
                                );
                              } else if (playing != true && timeRemaining! > 0) {
                                return IconButton(
                                  icon: Icon(Icons.play_arrow),
                                  iconSize: 86.0,
                                  color: Colors.white,
                                  onPressed: _onPlay, 
                                );
                              } else if (processingState != ProcessingState.completed &&
                                         timeRemaining! > 0) {
                                return IconButton(
                                  icon: Icon(Icons.pause),
                                  iconSize: 86.0,
                                  color: Colors.white,
                                  onPressed: _onPause,
                                );
                              } else {
                                return Container(
                                  child: Text(
                                    'Concluído',
                                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                                    ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      verticalSpace(8),
                      Container(
                         width: MediaQuery.of(context).size.width,
                         alignment: Alignment.center,
                         child: _showVolume(),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _showVolume() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.volume_mute),
          iconSize: 36.0,
          color: Colors.white,
          onPressed: () {},
        ),
        Observer(
          builder: (BuildContext context) {
            return Slider(
              min: 0.0,
              max: 2.0,
              value: 0.5,
              activeColor: Colors.white,
              onChanged: (value) {
                controller.setVolume(value);
                _player.setVolume(value);
              },
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.volume_up),
          iconSize: 36.0,
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }

  void loopPlayMusic() async  {
    watch.start();
    _startTimer(null);

  }

  ///Update time of circular progress bar
  String updateChartTime(timer) {
    if (watch.isRunning) {
      var milliseconds = timer;
      final hundreds = (milliseconds / 10).truncate();
      final seconds = (hundreds / 100).truncate();
      final minutes = (seconds / 60).truncate();
      elapsedTime =
          '${(minutes % 60).toString().padLeft(2, '0')} : ${(seconds % 60).toString().padLeft(2, '0')}';
      var data = _generateChartData(minutes, seconds);
      _chartKey.currentState!.updateData(data);
      return elapsedTime;
    } else {
      return '00:00';
    }
  }

  String initialDuration (int timerDuration) {
      return transformMilliseconds(timerDuration *1000);
  }

  String transformMilliseconds(int milliseconds) {
    final hundreds = (milliseconds / 10).truncate();
    final seconds = (hundreds / 100).truncate();
    final minutes = (seconds / 60).truncate();

    final minuteStr = (minutes % 60).toString().padLeft(2, '0');
    final secondStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minuteStr:$secondStr';
  }

  void _startTimer(int? time) async {
    var timeRemaining = time ?? widget.timerModel!.duration; 
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {

    if ((timeRemaining! + widget.timerModel!.soundEndDuration!) > 0) {  //extra time for endsound
        timeRemaining = timeRemaining! - 1;
        setState(() {
          if (timeRemaining! > 0) {
            elapsedTime = updateChartTime(timeRemaining!*1000);
          } else {
            elapsedTime = updateChartTime(0);
            watch.stop();
          }
        });
    } else {
        _timer!.cancel();
       // _player.stop();
       _player.pause(); 
       _player.seek(Duration.zero);
    }      
    });
  }


  // resume playing
  void _onPlay()  {
    _player.play();
    watch.start();
    _startTimer(timeRemaining);
    _saveTimerToPrefs();
  }

  void _onPause() {
    _player.pause();
    paused = true;
    setState(() {
      watch.stop();
    _timer!.cancel();
    });
  }

  void onDispose() {
    var duration = watch.elapsed.inSeconds;
    final df = DateFormat('yyyy-MM-dd');
    final tf = DateFormat('hh:mm');
    final dateMeditation = df.format(DateTime.now());
    final timeMeditation = tf.format(DateTime.now());

    final log = MeditationLog(
      duration: duration,
      date: DateTime.now(),
      type: 'timer',
    );
    
    // gravar log da meditation
    final _meditationStatisticsReposytory = Modular.get<MeditationStatisticsRepository>();
    _meditationStatisticsReposytory.saveMeditationStatistic(log);

        //gravar analytics de meditation
    final _analyticsService = Modular.get<AnalyticsService>();
    _analyticsService.logMeditation(
        title:  'timer',
        meditationId: '0',
        duration: duration,
        date: dateMeditation,
        time: timeMeditation,
        type: 'timer', 
    );

    //print('Tempo da meditação -> $duration');
    watch.stop();
    if (_timer != null) { 
        _timer!.cancel();
    }
  }


  /// check internet is available or not
  void checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Oops! Internet perdida'),
              content:
                  Text('Por favor verifique sua conexão com a Internet e depois tente novamente'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    checkConnectivity();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                )
              ],
            );
          });
    } else if (result == ConnectivityResult.mobile) {
    } else if (result == ConnectivityResult.wifi) {}
  }
}

class AnimatedCentralClock extends StatelessWidget {
  const AnimatedCentralClock({
    Key? key,
    required GlobalKey<AnimatedCircularChartState> chartKey,
    required Size chartSize,
    required String label,
  })  : _chartKey = chartKey,
        _chartSize = chartSize,
        _label = label,
        super(key: key);

  final GlobalKey<AnimatedCircularChartState> _chartKey;
  final Size _chartSize;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return AnimatedCircularChart(
      key: _chartKey,
      size: _chartSize,
      initialChartData:
          //_generateChartData(0,0),
          <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(
              00.00,
              Colors.blue,
              rankKey: 'completado',
            ),
            CircularSegmentEntry(
              100.00,
              Colors.white,
              rankKey: 'restando',
            ),
          ],
          rankKey: 'progresso',
        ),
      ],
      chartType: CircularChartType.Radial,
      percentageValues: false,
      holeLabel: _label,
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 42.0,
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            _showSliderDialog(
              context: context,
              title: 'Ajustar volume',
              divisions: 10,
              min: 0.0,
              max: 1.0,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero, index: 0),
              );
            }
          },
        ),
      ],
    );
  }
}

void _showSliderDialog({
  required BuildContext context,
  String? title,
  int? divisions,
  double? min,
  double? max,
  String valueSuffix = '',
  Stream<double>? stream,
  ValueChanged<double>? onChanged,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title!, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min!,
                max: max!,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
