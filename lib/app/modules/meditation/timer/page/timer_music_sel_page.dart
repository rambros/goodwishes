import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:just_audio/just_audio.dart';
import '/app/modules/meditation/timer/controller/timer_music_sel_controller.dart';
import '/app/shared/utils/animation.dart';
import '/app/shared/utils/ui_utils.dart';
import '/app/shared/widgets/get_image_url.dart';

import '../model/timer_music_model.dart';

class TimerMusicSelectionPage extends StatefulWidget {
  const TimerMusicSelectionPage({Key? key}) : super(key: key);

  @override
  _TimerMusicSelectionPageState createState() => _TimerMusicSelectionPageState();
}

class _TimerMusicSelectionPageState
    extends ModularState<TimerMusicSelectionPage, TimerMusicSelController> {
  late AudioPlayer _audioPlayer;

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

  @override
  void initState() {
    controller.init();
    _audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Música para o timer'),
        ),
        //backgroundColor: Colors.white, //Theme.of(context).accentColor,
        body: SingleChildScrollView(
          child: FadeAnimation(
            0.5,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                verticalSpace(24),
                Center(
                  child: Text('Música para Meditação',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                ),
                verticalSpace(16),
                _backgroundMusic(controller),
              ],
            ),
          ),
        ));
  }

  Widget _backgroundMusic(TimerMusicSelController controller) {
    final userRole = controller.getUserRole;
    return Observer(
      builder: (BuildContext context) {
        return Material(
          child: controller.timerMusics == null
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.timerMusics.length,
                  padding: EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        controller.setSelectedMusic(index);
                        if (_audioPlayer.playing == true) {
                          await _audioPlayer.stop();
                        };
                        if (index != 0) {
                           _playTimerMusic(controller.timerMusics[index]);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8.0, top: 8.0),
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        height: controller.timerMusics[index].imageUrl != null ? null : 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Material(
                          borderRadius: BorderRadius.circular(6.0),
                          elevation: 0.0,
                          child: Container(
                            height: 60.0,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: controller.timerMusics[index].imageUrl == null ||
                                              controller.timerMusics[index].imageUrl!.isEmpty
                                          ? Container()
                                          : GetImageUrl(
                                              imageUrl: controller.timerMusics[index].imageUrl,
                                              width: 60.0,
                                              height: 60.0)
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 2.0, top: 6.0),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              verticalSpace(12),
                                              _getTitle(controller.timerMusics[index].title),
                                            ]),
                                      ),
                                    ),
                                  ],
                                )),
                                Observer(
                                  builder: (BuildContext context) {
                                    return controller.selectedItem == index
                                        ? Icon(
                                            Icons.play_circle_filled,
                                            color: Theme.of(context).accentColor,
                                            size: 30,
                                          )
                                        : Icon(
                                            Icons.play_circle_outline,
                                            color: Theme.of(context).accentColor,
                                            size: 30,
                                          );
                                  },
                                ),
                                (userRole != 'Admin')
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                            child: IconButton(
                                                color: Theme.of(context).accentColor,
                                                icon: Icon(
                                                  Icons.delete,
                                                ),
                                                onPressed: () {
                                                  //widget.onDeleteItem();
                                                }),
                                          ),
                                        ],
                                      )
                                    : Material(), //Icon(Icons.favorite_border),
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
        );
      },
    );
  }

  void _playTimerMusic(TimerMusic tm) async {
    switch (tm.type) {
      case 'asset': await _audioPlayer.setAsset('assets/'+tm.audioLocation!);
        break;
      case 'file': await _audioPlayer.setFilePath(tm.audioLocation!);
        break; 
      case 'url': await _audioPlayer.setUrl(tm.audioLocation!);
        break; 
      default:
    }
    await _audioPlayer.play();
  }
}

Widget _getTitle(title) {
  return Text(
    title,
    maxLines: 1,
    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
    //style: titlePostTextStyle,
  );
}
