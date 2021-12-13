import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:share/share.dart';
import 'package:in_app_review/in_app_review.dart';

import '/app/shared/utils/animation.dart';
import '/app/shared/utils/ui_utils.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final InAppReview _inAppReview = InAppReview.instance;
  final String _appStoreId = '1524154748';

  Future<void> _requestReview() async {
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
    }
  }

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(appStoreId: _appStoreId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajude-nos a melhorar'),
        ),
        // body: WebView(
        //   initialUrl: 'https://docs.google.com/forms/d/e/1FAIpQLSfQ99__todk2o-kRIux56NLBuFnsOYi7mPyUnAAszUCrsjR3A/viewform',
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Positioned(
            top: -10,
            //height: MediaQuery.of(context).size.height,
            height: 800,
            width: MediaQuery.of(context).size.width,
            child: FadeAnimation(
              24,
              AnimatedOpacity(
                opacity: 0.4,
                duration: Duration(seconds: 20),
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  verticalSpace(48),
                  Center(
                    child: Text(
                        '''Ajude-nos a melhorar o MeditaBK. \n\nE você pode fazer isto de várias formas:''',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                  // verticalSpace(24),
                  // Center(
                  //   child: Text(
                  //     'Text2',
                  //     style: TextStyle(
                  //       fontSize: 16.0,
                  //       //color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                  verticalSpace(28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).colorScheme.secondary,
                        textColor: Colors.white,
                        elevation: 2,
                        onPressed: () {
                          Modular.to.pushNamed('/feedback');
                        },
                        child: Text('Dê a sua opinião sobre o app'.toUpperCase()),
                      ),
                    ],
                  ),
                  verticalSpace(28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).colorScheme.secondary,
                        textColor: Colors.white,
                        elevation: 2,
                        onPressed: () {
                          _openStoreListing();
                        },
                        child: Text('Faça uma avaliação na loja'.toUpperCase()),
                      ),
                    ],
                  ),
                  verticalSpace(28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).colorScheme.secondary,
                        textColor: Colors.white,
                        elevation: 2,
                        onPressed: () {
                          Modular.to.pushNamed('/feature');
                        },
                        child: Text('Sugerir uma melhoria'.toUpperCase()),
                      ),
                    ],
                  ),
                  verticalSpace(28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).colorScheme.secondary,
                        textColor: Colors.white,
                        elevation: 2,
                        onPressed: () {
                          Modular.to.pushNamed('/donation');
                        },
                        child: Text('Faça uma contribuição'.toUpperCase()),
                      ),
                    ],
                  ),
                  verticalSpace(28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).colorScheme.secondary,
                        textColor: Colors.white,
                        elevation: 2,
                        onPressed: () {
                          final RenderBox box = context.findRenderObject() as RenderBox;
                          Share.share(
                              'Oi, recentemente instalei este app de meditações da Brahma Kumaris. \nE ele é ótimo. Baixe uma cópia grátis aqui ${GlobalConfiguration().getString("dynamicLinkInvite")}',
                              subject: 'App MeditaBK',
                              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                        },
                        child: Text('Divulgue para seus conhecidos'.toUpperCase()),
                      ),
                    ],
                  ),
                  verticalSpace(500),
                  //Expanded(child: verticalSpace(16),),
                  // Center(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       controller.shareMensagem(mensagem);
                  //     },
                  //     child: Icon(Icons.share, size: 36.0),
                  //   ),
                  //),
                ],
              ),
            ),
          ),
        ])));
  }
}
