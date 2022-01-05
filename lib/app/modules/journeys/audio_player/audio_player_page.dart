import 'package:flutter/material.dart';

import '/app/shared/services/service_locator.dart';
import 'audio_player_controller.dart';
import 'player_model.dart';
import 'widgets/widgets.dart';

class ArgsPlayer {
  final PlayerModel? model;
  final List<Map<String, String>>? playlist;
  
  ArgsPlayer({this.model, this.playlist});
}

class AudioPlayerPage extends StatefulWidget {
  final ArgsPlayer? args;

  AudioPlayerPage({this.args});

  @override
  State<StatefulWidget> createState() => AudioPlayerPageState();
}

class AudioPlayerPageState extends State<AudioPlayerPage> { 

  @override
  void initState() {

    super.initState();
    //getIt<AudioPlayerController>().init(widget.model!);
    getIt<AudioPlayerController>().init(
      model: widget.args?.model!,
      playlist: widget.args?.playlist!);
  }

  @override
  void dispose() {
    //getIt<AudioPlayerController>().saveStatistics(widget.model!);
    getIt<AudioPlayerController>().dispose();
    getIt.resetLazySingleton<AudioPlayerController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 50),
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: FloatingActionButton(
            elevation: 10,
            backgroundColor: Colors.white,
            onPressed: dispose,
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
            color: Theme.of(context).colorScheme.primary,
          ),
          Positioned(
              top: 120,
              left: 0,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    widget.args?.model!.title ?? 'Meditação Conduzida',
                    style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            child: Center(
                  child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CurrentSongTitle(),
                          Playlist(),
                          //AddRemoveSongButtons(),
                          SizedBox(height: 10,),
                          //CentralClock(),
                          AudioControlButtons(),
                          SizedBox(height: 40,),
                          AudioProgressBar(),
                        ],
                      ),
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}












