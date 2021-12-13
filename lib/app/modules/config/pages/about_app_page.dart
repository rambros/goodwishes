import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '/app/shared/utils/ui_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutAppPage extends StatefulWidget {
  const AboutAppPage({Key? key}) : super(key: key);
  @override
  _AboutAppPageState createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {

  String? version;

  @override
  void initState() { 
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo)  {
      setState(() {
        version = packageInfo.version;
      });
    }
    );;
  }

  String? get versionNumber => version;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre a Brahma Kumaris'),
      ),
      body: ListView(
        children: <Widget>[
          Stack(children: <Widget>[
            // The containers in the background
            Column(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .30,//30
                color: Theme.of(context).accentColor,
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Column(
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        child: Image.asset('assets/images/logo-ponto-bk.png',
                            width: 300, height: 150),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            Column(
              children: <Widget>[
                verticalSpace(8),
                Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .20,//18
                        right: 20.0,
                        left: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.white,
                        elevation: 4.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[],
                        ),
                      ),
                    )),
                Container(
                    padding: EdgeInsets.only(top: 20, right: 8.0, left: 8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                            //color: Colors.white,
                            elevation: 4.0,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 16, 16, 16),
                                            child: HtmlWidget(
'''A <b>Brahma Kumaris</b> é um movimento espiritual mundial dedicado à transformação pessoal e à renovação do mundo. Fundada na Índia em 1937, difundiu-se para mais de 110 países em todos os continentes, tendo um amplo impacto em muitos setores, como uma ONG internacional. <br><br>Seu verdadeiro compromisso é ajudar as pessoas a transformarem sua perspectiva em relação ao mundo, de material para espiritual. \n\nApoia a cultura de uma profunda consciência coletiva de paz e dignidade individual de cada ser.

<br><br>No Brasil, as atividades da BK começaram em 1979, com sedes nas principais capitais e em cidades do interior.<br><br>

Para mais informações, acesse o site da Brahma Kumaris clicando no botão abaixo: ''',
                                            ),
                                              // textAlign: TextAlign.justify,
                                              // style: TextStyle(
                                              //   fontSize: 16.0,
                                              //   height: 1.0,
                                              //   //color: Colors.black54,
                                              // ),
                                            ),
                                            ),
                                  ],
                                ),
                                
                                RaisedButton(
                                      onPressed: _launchURL,
                                      child: Text('Site da Brahma Kumaris',style: TextStyle(color: Colors.white)),
                                      color: Theme.of(context).accentColor,
                                ),
                                verticalSpace(8),
                              ],
                            )))),
              ],
            ),
          ])
        ],
      ),
    );
  }

void _launchURL() async {
  const url = 'https://www.brahmakumaris.org.br';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

}
