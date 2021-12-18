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
          Modular.to.pushReplacementNamed('/login/sociallogin');
        } else {
          _userService.populateCurrentUser(_authenticationService.currentAuthUser);
          Modular.to.pushReplacementNamed('/'); 
        }
      },
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  
      body: Center(
        child: 
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/logo_goodwishes.png',
                      width: 220, height: 220),
                  verticalSpace(12),
                  Image.asset('assets/images/goodwishes_text.png',
                      width: 350, height: 48),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text('Good',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w700,
                  //         fontSize: 48,
                  //         color: Theme.of(context).colorScheme.primary,
                  //       )),
                  //     Text('Wishes',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w700,
                  //         fontSize: 48,
                  //         color: Theme.of(context).colorScheme.primaryVariant,
                  //       )),
                  //   ],
                  // ),
                  verticalSpace(16),
                  Text('Version $version',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary, 
                    ),
                  ),
                ],
              ),
            ),
        ),
    );
  }
}
