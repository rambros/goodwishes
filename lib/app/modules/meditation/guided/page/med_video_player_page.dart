import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/app/shared/utils/ui_utils.dart';
import 'package:share/share.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MeditationVideoPlayerPage extends StatefulWidget {
  final String? id;

  MeditationVideoPlayerPage({this.id});

  @override
  _MeditationVideoPlayerPageState createState() => _MeditationVideoPlayerPageState();
}

class _MeditationVideoPlayerPageState extends State<MeditationVideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id!,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var msgToShare =
        '''*App MeditaBK - Brahma Kumaris*\nMeditaçãoes com vídeo\nVeja o vídeo no link abaixo\nhttps://www.youtube.com/watch?v=${widget.id}''';
    //' ${GlobalConfiguration().getString("dynamicLinkInvite")}''';
    return Scaffold(
      body: showLandscape(msgToShare),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //       elevation: 0,
    //       backgroundColor: (MediaQuery.of(context).orientation == Orientation.landscape) 
    //           ? Colors.transparent
    //           : Theme.of(context).accentColor,
    //       title: Text('Meditação com vídeo'),
    //       actions: <Widget>[
    //         (MediaQuery.of(context).orientation == Orientation.landscape)
    //         ? IconButton(
    //             icon: Icon(Icons.stay_current_portrait),
    //             onPressed: () {
    //               SystemChrome.setPreferredOrientations(
    //                   [DeviceOrientation.portraitUp]);
    //             })
    //         : IconButton(
    //             icon: Icon(Icons.stay_primary_landscape),
    //             onPressed: () {
    //               SystemChrome.setPreferredOrientations(
    //                   [DeviceOrientation.landscapeLeft]);
    //             })   
    //       ]),
    //   body: (MediaQuery.of(context).orientation == Orientation.landscape)
    //             ? showLandscape()
    //             : showPortrait(msgToShare)
    // );
  }

  Widget showPortrait(String msgToShare) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        verticalSpace(48),
        RichText(
          text: TextSpan(
            text: 'Meditação com ',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700]),
            children: <TextSpan>[
              TextSpan(
                  text: 'vídeo',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        verticalSpace(36),
        YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            //print('Player is ready.');
          },
        ),
        verticalSpace(48),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor, // background
                onPrimary: Colors.white, // foreground
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              //color: Theme.of(context).accentColor,
              //textColor: Colors.white,
              onPressed: () {
                final RenderBox box = context.findRenderObject() as RenderBox;
                Share.share(msgToShare,
                    subject: 'App MeditaBK',
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              },
              child: Text('Compartilhe o link deste vídeo'.toUpperCase()),
            ),
          ],
        ),
      ],
    );
  }

 Widget showLandscape(String msgToShare) {
    SystemChrome.setPreferredOrientations(
                       [DeviceOrientation.landscapeLeft]);
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            _controller.play();
          },
          topActions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                      icon: const Icon(
                        Icons.backspace,
                        color: Colors.white),
                        onPressed: () {
                          _controller.pause();
                          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                          Navigator.pop(context);
                        }
                      ),
                SizedBox(width: 230),
                IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white),
                        onPressed: () {
                          final RenderBox box = context.findRenderObject() as RenderBox;
                          Share.share(msgToShare,
                              subject: 'App MeditaBK',
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size);
                        },
                      ),
              ],
            ),
          ],
        ),
        builder: (context, player){
            return Column(
              children: [ 
                  Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: Text('Vídeo'),
                  ),
                  player,
                  //some other widgets
              ],
            );
        },
    );
  }
}
