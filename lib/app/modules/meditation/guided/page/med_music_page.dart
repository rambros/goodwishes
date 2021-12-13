import 'package:flutter/material.dart';
import '/app/shared/utils/animation.dart';

class MeditationMusicPage extends StatefulWidget {
  const MeditationMusicPage({Key? key}) : super(key: key);

  @override
  _MeditationMusicPageState createState() => _MeditationMusicPageState();
}

class _MeditationMusicPageState extends State<MeditationMusicPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditar com músicas'),
      ),
      backgroundColor: Colors.white,  //Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: FadeAnimation(
            0.5,
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/med-embreve.png',
                      fit: BoxFit.fill,
                      //width: 220, height: 220,
                      ),
                ],
              ),
            )),
      ),
    );
  }
}
