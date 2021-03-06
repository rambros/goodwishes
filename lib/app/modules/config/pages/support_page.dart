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

  // Future<void> _requestReview() async {
  //   if (await _inAppReview.isAvailable()) {
  //     await _inAppReview.requestReview();
  //   }
  // }

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
                        '''Ajude-nos a melhorar o MeditaBK. \n\nE voc?? pode fazer isto de v??rias formas:''',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                  verticalSpace(28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          primary: Theme.of(context).colorScheme.secondary,// background
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                        onPressed: () {
                          Modular.to.pushNamed('/feedback');
                        }, 
                        child: Text('D?? a sua opini??o sobre o app'.toUpperCase()),
                      )
                    ],
                  ),
                  verticalSpace(28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          primary: Theme.of(context).colorScheme.secondary,// background
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                        onPressed: () {
                          _openStoreListing();
                        }, 
                        child: Text('Fa??a uma avalia????o na loja'.toUpperCase()),
                      )
                    ],
                  ),
                  verticalSpace(28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          primary: Theme.of(context).colorScheme.secondary,// background
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          primary: Theme.of(context).colorScheme.secondary,// background
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                        onPressed: () {
                          Modular.to.pushNamed('/donation');
                        }, 
                        child: Text('Fa??a uma contribui????o'.toUpperCase()),
                      ),
                    ],
                  ),
                  verticalSpace(28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          primary: Theme.of(context).colorScheme.secondary,// background
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                        onPressed: () {
                          final box = context.findRenderObject() as RenderBox;
                          Share.share(
                              'Oi, recentemente instalei este app de medita????es da Brahma Kumaris. \nE ele ?? ??timo. Baixe uma c??pia gr??tis aqui ${GlobalConfiguration().getValue("dynamicLinkInvite")}',
                              subject: 'App MeditaBK',
                              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                        }, 
                        child: Text('Divulgue para seus conhecidos'.toUpperCase()),
                      ),
                    ],
                  ),
                  verticalSpace(500),
                ],
              ),
            ),
          ),
        ])));
  }
}
