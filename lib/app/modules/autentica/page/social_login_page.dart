import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/app/modules/autentica/controller/social_login_controller.dart';
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
                      Image.asset('assets/images/logo_goodwishes.png',
                        width: 180, height: 180),
                      verticalSpace(8),
                      Image.asset('assets/images/goodwishes_text.png',
                        width: 320, height: 42),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Text(
                                'Community of well-wishers for a whole new world',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18, 
                                  fontWeight: FontWeight.w500,
                                )),
                            ),
                            verticalSpace(2),
                            // Text('Please Login to continue',
                            //     style: TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w400,
                            //         color: Colors.grey)),
                          ],
                        ),
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
              Text("Don't have a social media account?"),
              TextButton(
                onPressed: () {
                  controller.gotoSignInWithEmail();
                },
                child: Text(
                  'Continue with Email >>',
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
              ' Login with Google',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          : Text(
              ' Completed',
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
              ' Login with Facebook',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          : Text(
              ' Completed',
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
              ' Login with Apple',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          : Text(
              ' Completed',
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
