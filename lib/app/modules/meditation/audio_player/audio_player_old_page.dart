import 'dart:async';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_player_old_controller.dart';
import './player_model.dart';
import './seek_bar.dart';
import '../statistics/model/meditation_log.dart';
import '../statistics/repository/med_statistics_repository.dart';
import './../../../shared/services/analytics_service.dart';


class AudioPlayerPage extends StatefulWidget {
  final PlayerModel? model;
  AudioPlayerPage({this.model});

  @override
  State<StatefulWidget> createState() => AudioPlayerPageState();
}

class AudioPlayerPageState
    extends ModularState<AudioPlayerPage, AudioPlayerController> {
  int? totaltime, sessioncompleted, averageduration;

  late AudioPlayer _audioPlayer;
  double position = 0;
  int buffering = 0;

  Stopwatch watch = Stopwatch();
  Timer? timer; 
  String elapsedTime = '00:00';

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
              content: Text(
                  'Por favor verifique sua conexão com a Internet e depois tente novamente'),
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

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    //AudioPlayer.setIosCategory(IosCategory.playback);
    _audioPlayer = AudioPlayer();
    _initSession();
    //_audioPlayer.setUrl(widget.model.urlAudio);
  }

  void _initSession() async {

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
    try {
      await _audioPlayer.setUrl(widget.model!.urlAudio!);
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print('An error occured $e');
    }
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  final _chartSize = const Size(300.0, 300.0);
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();

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
          ((_audioPlayer.playbackEvent.duration!.inMilliseconds / 1000).round() -
              second.toDouble()),
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
          // ParticleAnimation(
          //   screenSize: MediaQuery.of(context).size,
          //   bgColor:  Colors.black, //Theme.of(context).accentColor,
          // ),
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
                    widget.model!.title ?? 'Meditação Conduzida',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
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
                        //monta relogio central
                        StreamBuilder<Duration?>(
                          stream: _audioPlayer.durationStream,
                          builder: (context, snapshot) {
                            final duration = snapshot.data ?? Duration.zero;
                            return StreamBuilder<Duration>(
                              stream: _audioPlayer.positionStream,
                              builder: (context, snapshot) {
                                var position = snapshot.data ?? Duration.zero;
                                if (position > duration) {
                                  position = duration;
                                }
                                var timeRemaining = duration - position;
                                elapsedTime = (timeRemaining == Duration.zero || timeRemaining == null) 
                                    ? updateTime(Duration.zero)
                                    : updateTime(timeRemaining);
                                //elapsedTime = updateTime(position.inMilliseconds)
                                //              ?? transformMilliseconds(
                                //                    duration.inMilliseconds);
                                return AnimatedCentralClock(
                                  chartKey: _chartKey,
                                  chartSize: _chartSize,
                                  label: '$elapsedTime',
                                );
                              },
                            );
                          },
                        ),
                        // gerencia botões
                        StreamBuilder<PlayerState>(
                          stream: _audioPlayer.playerStateStream,
                          builder: (context, snapshot) {
                            final playerState = snapshot.data;
                            final processingState = playerState?.processingState;
                            final playing = playerState?.playing;
                            if (processingState == ProcessingState.completed) watch.stop();
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (processingState == ProcessingState.loading ||
                                    processingState == ProcessingState.buffering)
                                  Container(
                                    margin: EdgeInsets.all(8.0),
                                    width: 64.0,
                                    height: 64.0,
                                    child: CircularProgressIndicator(),
                                  )
                                else if (playing != true)
                                  IconButton(
                                    icon: Icon(Icons.play_arrow),
                                    iconSize: 86.0,
                                    color: Colors.white,
                                    onPressed: onPlay,
                                  )  
                                else if (processingState != ProcessingState.completed)
                                  IconButton(
                                    icon: Icon(Icons.pause),
                                    iconSize: 86.0,
                                    color: Colors.white,
                                    onPressed: onPause,
                                  )
                                else Container(
                                  height: 86,
                                  child: Text(
                                    'Concluído',
                                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                                    ),
                                )
                              ],
                            );
                          },
                        ),
                        //Track position"
                        StreamBuilder<Duration?>(
                          stream: _audioPlayer.durationStream,
                          builder: (context, snapshot) {
                            final duration = snapshot.data ?? Duration.zero;
                            return StreamBuilder<Duration>(
                              stream: _audioPlayer.positionStream,
                              builder: (context, snapshot) {
                                var position = snapshot.data ?? Duration.zero;
                                if (position > duration) {
                                  position = duration;
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      transformMilliseconds(0),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Container(
                                      child: SeekBar(
                                        duration: duration,
                                        position: position,
                                        onChangeEnd: (newPosition) {
                                          _audioPlayer.seek(newPosition);
                                          updateTime(newPosition);
                                        },
                                      ),
                                    ),
                                    Text(
                                      transformMilliseconds(
                                          duration.inMilliseconds),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    // IconButton(
                                    //   icon: Icon(Icons.skip_next),
                                    //   iconSize: 36.0,
                                    //   color: Colors.white,
                                    //   onPressed: () {},
                                    // ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        //SizedBox(height: 20),
                        //Text("Volume"),
                        // _showVolume(),
                        //SizedBox(height: 20.0,),
                        //_showComments(),
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }

  

  // Widget _showVolume() {
  //   return Row(
  //     children: <Widget>[
  //       IconButton(
  //         icon: Icon(Icons.volume_mute),
  //         iconSize: 36.0,
  //         color: Colors.white,
  //         onPressed: () {},
  //       ),
  //       Observer(
  //         builder: (BuildContext context) {
  //           return Slider(
  //             min: 0.0,
  //             max: 2.0,
  //             value: controller.volume ?? 1.0,
  //             onChanged: (value) {
  //               controller.setVolume(value);
  //               _audioPlayer.setVolume(value);
  //             },
  //           );
  //         },
  //       ),
  //       IconButton(
  //         icon: Icon(Icons.volume_up),
  //         iconSize: 36.0,
  //         color: Colors.white,
  //         onPressed: () {},
  //       ),
  //     ],
  //   );
  // }

  ///Update time of circular progress bar
  String updateTime(Duration timer) {

      var milliseconds = timer.inMilliseconds;
      var hundreds = (milliseconds / 10).truncate();
      var seconds = (hundreds / 100).truncate();
      var minutes = (seconds / 60).truncate();

      if (watch.isRunning) {    
        var data = _generateChartData(minutes, seconds);
        _chartKey.currentState?.updateData(data);
      }
      elapsedTime =
          '${(minutes % 60).toString().padLeft(2, '0')} : ${(seconds % 60).toString().padLeft(2, '0')}';
      return elapsedTime;
  }

  String transformMilliseconds(int milliseconds) {
    var hundreds = (milliseconds / 10).truncate();
    var seconds = (hundreds / 100).truncate();
    var minutes = (seconds / 60).truncate();

    var minuteStr = (minutes % 60).toString().padLeft(2, '0');
    var secondStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minuteStr:$secondStr';
  }

  void onPlay() {
    _audioPlayer.play();
    watch.start();
  }

  void onPause() {
    _audioPlayer.pause();
    watch.stop();
  }

  void onDispose() async {

    var duration = watch.elapsed.inSeconds;
    final df = DateFormat('yyyy-MM-dd');
    final tf = DateFormat('hh:mm');
    final dateMeditation = df.format(DateTime.now());
    final timeMeditation = tf.format(DateTime.now());

    final log = MeditationLog(
      duration: duration,
      date: DateTime.now(),
      type: 'guided',
    );
    
    // gravar log da meditation
    final _meditationStatisticsReposytory = Modular.get<MeditationStatisticsRepository>();
    _meditationStatisticsReposytory.saveMeditationStatistic(log);

    //gravar analytics de meditation
    final _analyticsService = Modular.get<AnalyticsService>();
    await _analyticsService.logMeditation(
        title:  widget.model!.title,
        meditationId: widget.model!.id,
        duration: duration,
        date: dateMeditation,
        time: timeMeditation,
        type: 'conduzida', 
    );

    //await  _audioPlayer.stop();
    try {
      await _audioPlayer.dispose();
    } catch (e) {
      print('An error occured $e');
    }
    
    watch.stop();
  }

  void onSeek(double value) {
    _audioPlayer.seek(Duration(milliseconds: value.toInt()));
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
          // todo: Refactor.
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
        fontSize: 44.0,
      ),
    );
  }
}
