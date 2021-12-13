import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '/app/shared/utils/animation.dart';
import '/app/shared/utils/ui_utils.dart';

class DonationPage extends StatefulWidget {
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doação para o MeditaBk'),
      ),
      body: SingleChildScrollView(
          child: Stack(children: <Widget>[
        Positioned(
          top: -10,
          //height: MediaQuery.of(context).size.height,
          height: 800,
          width: MediaQuery.of(context).size.width,
          child: FadeAnimation(
            6,
            AnimatedOpacity(
              opacity: 0.7,
              duration: Duration(seconds: 12),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.linearToSrgbGamma(),
                        image: AssetImage('assets/images/shiva-point.jpg'),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpace(48),
              Center(
                child: Text('Como contribuir com a Brahma Kumaris e o MeditaBK',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              ),
              verticalSpace(24),
              Center(
                child: Text(
                  '''Acreditando que as coisas do espírito devem ser acessíveis a todos, a Brahma Kumaris oferece suas atividades com base em contribuições voluntárias de pessoas que sentem que receberam benefício pessoal ao participarem de cursos, palestras e outros programas. Neste sentido, mesmos os centros e centros de retiro da Brahma Kumaris são também dirigidos por voluntários.
                \n\nVocê pode fazer uma contribuição financeira para o trabalho nacional da Brahma Kumaris através da internet. Para contribuições,  favor clicar no botão abaixo que leverá você para o site da Brahma Kumaris:
                ''',
                  style: TextStyle(
                    fontSize: 16.0,
                    //color: Colors.black,
                  ),
                ),
              ),
              verticalSpace(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      textStyle: const TextStyle(
                            fontSize: 19, //44 * 0,43
                            fontWeight: FontWeight.normal,
                            fontFamily: '.SF Pro Text',
                            letterSpacing: -0.41,
                            color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      _launchURL();
                    },
                    child: Text('Ir para o site da Brahma Kumaris'),
                  ),
                ],
              ),
              verticalSpace(500),
            ],
          ),
        ),
      ])),
    );
  }

  void _launchURL() async {
    const url =
        'https://www.brahmakumaris.org.br/institucional/como-contribuir';
    if (await canLaunch(url)) {
      await launch(url, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
