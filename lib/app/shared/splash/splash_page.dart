import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info/package_info.dart';

import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/user_service.dart';
import '/app/shared/utils/ui_utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _userService = Modular.get<UserService>();
  final _authenticationService = Modular.get<AuthenticationService>();
  String? version;
  @override
  void initState()  {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo)  {
      setState(() {
        version = packageInfo.version;
      });
    }
    );
    Future.delayed(Duration(milliseconds: 2000), () { 
      if (_authenticationService.isUserLoggedIn() == false) {
        //if (_userService.currentUser == null) {
          Modular.to.pushReplacementNamed('/login');
        } else {
          _userService.populateCurrentUser(_authenticationService.currentAuthUser);
          Modular.to.pushReplacementNamed('/');  //original é home /
        }
      },
      );
    }

  // disposer = autorun((_) {
  //   final auth = Modular.get<AuthenticationService>();
  // if (auth.status == AuthenticationStatus.loggedIn) {
  //   Modular.to.pushReplacementNamed('/');
  // } else if (auth.status == AuthenticationStatus.loggedOut) {
  //   Modular.to.pushReplacementNamed('/welcome');
  //}
  //   });
  // @override
  // void dispose() {
  //   super.dispose();
  //   disposer();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  //Theme.of(context).accentColor,
      body: Center(
        child: 
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/logo_meditabk_2020.png',
                      width: 220, height: 220),
                  verticalSpace(24),
                  Text('MeditaBK',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 48,
                        color: Colors.red[800],
                      )),
                  Text('Versão $version'),
                ],
              ),
            ),
        ),
    );
  }
}
