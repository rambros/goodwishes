import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/autentica/page/profile.dart';
import 'controller/forget_password_controller.dart';
import 'controller/intro_controller.dart';
import 'controller/sign_in_controller.dart';
import 'controller/sign_up_controller.dart';
import 'controller/social_login_controller.dart';
import 'page/intro_page.dart';
import 'page/sign_in_page.dart';
import 'page/sign_up_page.dart';
import 'page/social_login_page.dart';
import 'services/internet_service.dart';

class AutenticaModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => SocialLoginController()),
    Bind((i) => SignInController()),
    Bind((i) => SignUpController()),
    Bind((i) => ForgetPasswordController()),
    Bind((i) => InternetService()),
    Bind((i) => IntroController()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/sociallogin', child: (_,args) => SocialLoginPage()),
    ChildRoute('/intro', child: (_,args) => IntroPage()),
    ChildRoute('/signin', child: (_,args) => SignInPage()),
    ChildRoute('/signup', child: (_,args) => SignUpPage()),
    ChildRoute('/profile', child: (_,args) => ProfilePage()),
  ];

}
