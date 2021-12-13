import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/services/authentication_service.dart';

class IntroController {
  final sb = Modular.get<AuthenticationService>();

  void afterIntroComplete (){
    sb.setSignIn();
    Modular.to.navigate('/');
  }
}