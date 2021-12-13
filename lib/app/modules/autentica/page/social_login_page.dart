import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/app/modules/autentica/controller/social_login_controller.dart';
import '/app/modules/autentica/util/config.dart';
import '/app/shared/services/authentication_service.dart';
import '/app/shared/utils/ui_utils.dart';

class SocialLoginPage extends StatefulWidget {
  const SocialLoginPage({Key? key}) : super(key: key);

  @override
  _SocialLoginPageState createState() => _SocialLoginPageState();
}

class _SocialLoginPageState
    extends ModularState<SocialLoginPage, SocialLoginController> {
  final _auth = Modular.get<AuthenticationService>();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: () async => controller.exitApp(),
          child: Scaffold(
        //backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage(Config().splashIcon),
                        height: 130,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Bem-vindo ao MeditaBK',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700)),
                          verticalSpace(2),
                          Text('Faça Login pra continuar',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey)),
                        ],
                      ),
                    ],
                  )),

              // Login Google
              Observer(
                builder: (BuildContext context) {
                  return Container(
                    height: 45,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.12,
                        right: MediaQuery.of(context).size.width * 0.12),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(25)),
                    child: AnimatedPadding(
                        padding: EdgeInsets.only(
                          left: controller.leftPaddingGoogle,
                          right: controller.rightPaddingGoogle,
                        ),
                        duration: Duration(milliseconds: 1000),
                        child: AnimatedCrossFade(
                          duration: Duration(milliseconds: 400),
                          firstChild: _firstChildGoogle(),
                          secondChild: controller.signInCompleteGoogle == false
                              ? _secondChildGoogle()
                              : _firstChildGoogle(),
                          crossFadeState: controller.signInStartGoogle == false
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        )),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),

              // Login Facebook
              Observer(
                builder: (BuildContext context) {
                  return Container(
                    height: 45,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.12,
                        right: MediaQuery.of(context).size.width * 0.12),
                    decoration: BoxDecoration(
                        color: Colors.indigo[400],
                        borderRadius: BorderRadius.circular(25)),
                    child: AnimatedPadding(
                      padding: EdgeInsets.only(
                        left: controller.leftPaddingFb,
                        right: controller.rightPaddingFb,
                      ),
                      duration: Duration(milliseconds: 1000),
                      child: AnimatedCrossFade(
                        duration: Duration(milliseconds: 400),
                        firstChild: _firstChildFb(_auth),
                        secondChild: controller.signInCompleteFb == false
                            ? _secondChildFb()
                            : _firstChildFb(_auth),
                        crossFadeState: controller.signInStartFb == false
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                      ),
                    ),
                  );
                },
              ),

              //Login Apple - verifica se está disponivel para este device
              FutureBuilder(
                future: controller.appleSignInAvailable,
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return Column(children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Observer(
                        builder: (BuildContext context) {
                          return Container(
                              height: 45,
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.12,
                                  right:
                                      MediaQuery.of(context).size.width * 0.12),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25)),
                              child: AnimatedPadding(
                                  padding: EdgeInsets.only(
                                    left: controller.leftPaddingApple,
                                    right: controller.rightPaddingApple,
                                  ),
                                  duration: Duration(milliseconds: 1000),
                                  child: AnimatedCrossFade(
                                    duration: Duration(milliseconds: 400),
                                    firstChild: _firstChildApple(_auth),
                                    secondChild:
                                        controller.signInCompleteApple == false
                                            ? _secondChildApple()
                                            : _firstChildApple(_auth),
                                    crossFadeState:
                                        controller.signInStartApple == false
                                            ? CrossFadeState.showFirst
                                            : CrossFadeState.showSecond,
                                  )));
                        },
                      ),
                    ]);
                  } else {
                    return Container();
                  }
                },
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // Observer(
              //   builder: (BuildContext context) {
              //     return Container(
              //         height: 45,
              //         margin: EdgeInsets.only(
              //             left: MediaQuery.of(context).size.width * 0.12,
              //             right: MediaQuery.of(context).size.width * 0.12),
              //         decoration: BoxDecoration(
              //             color: Colors.indigo[400],
              //             borderRadius: BorderRadius.circular(25)),
              //         child: AnimatedPadding(
              //             padding: EdgeInsets.only(
              //               left: controller.leftPaddingApple,
              //               right: controller.rightPaddingApple,
              //             ),
              //             duration: Duration(milliseconds: 1000),
              //             child: AnimatedCrossFade(
              //               duration: Duration(milliseconds: 400),
              //               firstChild: _firstChildApple(_auth),
              //               secondChild: controller.signInCompleteApple == false
              //                   ? _secondChildApple()
              //                   : _firstChildApple(_auth),
              //               crossFadeState: controller.signInStartApple == false
              //                   ? CrossFadeState.showFirst
              //                   : CrossFadeState.showSecond,
              //             )));
              //   },
              // ),

              Spacer(),
              Text('Não tem conta nas redes sociais? '),
              TextButton(
                onPressed: () {
                  controller.gotoSignInWithEmail();
                },
                child: Text(
                  'Continue com Email >>',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      //color: Theme.of(context).primaryColorDark,
                      ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstChildGoogle() {
    return TextButton.icon(
      icon: controller.signInCompleteGoogle == false
          ? Icon(
              FontAwesomeIcons.google,
              size: 22,
              color: Colors.white,
            )
          : Icon(
              Icons.done,
              size: 25,
              color: Colors.white,
            ),
      label: controller.signInCompleteGoogle == false
          ? Text(
              ' Login com Google',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          : Text(
              ' Concluído',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
      onPressed: () {
        controller.handleGoogleSignIn();
      },
    );
  }

  Widget _secondChildGoogle() {
    return Container(
      // height: 45,
      // margin: EdgeInsets.only(
      //     left: MediaQuery.of(context).size.width * 0.12,
      //     right:
      //         MediaQuery.of(context).size.width * 0.12),
      child: Container(
          padding: EdgeInsets.all(10),
          height: 45, //45
          width: 45, //45
          child: CircularProgressIndicator(
            strokeWidth: 3,
          )),
    );
  }

  Widget _firstChildFb(sb) {
    return TextButton.icon(
      icon: controller.signInCompleteFb == false
          ? Icon(
              FontAwesomeIcons.facebook,
              size: 22,
              color: Colors.white,
            )
          : Icon(
              Icons.done,
              size: 25,
              color: Colors.white,
            ),
      label: controller.signInCompleteFb == false
          ? Text(
              ' Login com Facebook',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          : Text(
              ' Concluído',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
      onPressed: () {
        controller.handleFacebookLogin();
      },
    );
  }

  Widget _secondChildFb() {
    return Container(
      height: 45,
      width: 45,
      child: Container(
          padding: EdgeInsets.all(10),
          height: 35, //45
          width: 35, //45
          child: CircularProgressIndicator(
            strokeWidth: 3,
          )),
    );
  }

  Widget _firstChildApple(sb) {
    return TextButton.icon(
      icon: controller.signInCompleteApple == false
          ? Icon(
              FontAwesomeIcons.apple,
              size: 22,
              color: Colors.white,
            )
          : Icon(
              Icons.done,
              size: 25,
              color: Colors.white,
            ),
      label: controller.signInCompleteApple == false
          ? Text(
              ' Continuar com a Apple',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          : Text(
              ' Concluído',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
      onPressed: () {
        controller.handleAppleLogin();
      },
    );
  }

  Widget _secondChildApple() {
    return Container(
        padding: EdgeInsets.all(10),
        height: 45,
        width: 45,
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ));
  }
}
