import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:just_audio/just_audio.dart';
import '/app/modules/meditation/timer/controller/timer_start_sound_sel_controller.dart';
import '/app/modules/meditation/timer/model/timer_sound_model.dart';
import '/app/shared/utils/animation.dart';
import '/app/shared/utils/ui_utils.dart';
import '/app/shared/widgets/get_image_url.dart';

class TimerStartSoundSelectionPage extends StatefulWidget {
  const TimerStartSoundSelectionPage({Key? key}) : super(key: key);

  @override
  _TimerStartSoundSelectionPageState createState() => _TimerStartSoundSelectionPageState();
}

class _TimerStartSoundSelectionPageState
    extends ModularState<TimerStartSoundSelectionPage, TimerStartSoundSelController> {
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
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  onPressed: () {
                    checkConnectivity();
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    } else if (result == ConnectivityResult.mobile) {
    } else if (result == ConnectivityResult.wifi) {}
  }

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    if (_audioPlayer.playing == true) {
       _audioPlayer.stop();
    };
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Som para iniciar o timer'),
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
                  child: Text('Som para iniciar o timer',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                ),
                verticalSpace(16),
                _startSound(controller),
              ],
            ),
          ),
        ));
  }

  Widget _startSound(TimerStartSoundSelController controller) {
    final userRole = controller.getUserRole;
    return Material(
          child: controller.timerSounds == null
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
                  itemCount: controller.timerSounds.length,
                  padding: EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        controller.setSelectedStartSound(index);
                        if (_audioPlayer.playing == true) {
                          await _audioPlayer.stop();
                        };
                        if (index != 0) {
                            _playTimerSound(controller.timerSounds[index]);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 4.0, top: 4.0),
                        padding: EdgeInsets.only(
                          right: 10,
                        ),
                        height: controller.timerSounds[index].imageUrl != null ? null : 48,
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
                            height: 48.0,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: controller.timerSounds[index].imageUrl == null ||
                                              controller.timerSounds[index].imageUrl!.isEmpty
                                          ? Container()
                                          : GetImageUrl(
                                              imageUrl: controller.timerSounds[index].imageUrl,
                                              width: 48.0,
                                              height: 48.0)
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 2.0, top: 6.0),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              verticalSpace(8),
                                              _getTitle(controller.timerSounds[index].title),
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
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
        );
  }

  void _playTimerSound(TimerSound ts) async {
    await _audioPlayer.setAsset('assets/'+ts.audioFilePath!);
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
