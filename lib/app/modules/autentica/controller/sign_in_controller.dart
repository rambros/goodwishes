import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '/app/shared/services/analytics_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/user_service.dart';
import '../services/internet_service.dart';
part 'sign_in_controller.g.dart';

class SignInController = _SignInControllerBase with _$SignInController;
abstract class _SignInControllerBase with Store {
  final _authenticationService = Modular.get<AuthenticationService>();
  final _is = Modular.get<InternetService>();
  final _dialogService = Modular.get<DialogService>();
  final _userService = Modular.get<UserService>();
  final _analyticsService = Modular.get<AnalyticsService>();


  @observable
  bool signInStart = false;
  @observable
  bool signInComplete = false;

  void init() {
    signInComplete = false;
    signInStart = false;
  }

    void handleSignInwithEmailPassword({String? email, String? pass}) async {
    _is.checkInternet();
    if (_is.hasInternet == false) {
      await _dialogService.showDialog(
        title: 'Sem Internet',
        description: 'Verifique sua conexão de internet',
      );
    } else {
      signInStart = true;
      var _firebaseUser = await _authenticationService.signInwithEmailPassword(email, pass); 
      if (_authenticationService.hasError == false) {
          await _userService.populateCurrentUser(_firebaseUser);
          await _authenticationService.setSignIn();
          // set the user id on the analytics service
          //await _analyticsService.setUserProperties(userId: _firebaseUser.user.uid);
          await _analyticsService.logLogin();
          signInComplete = true;
          handleAfterSignin();
        } else {
          signInStart = false;
          var error;
          switch ( _authenticationService.errorCode) {
            case 'ERROR_INVALID_EMAIL' : error = 'Email inválido';
               break;
            case 'ERROR_WRONG_PASSWORD' : error = 'Senha errada';
               break;
            case 'ERROR_USER_NOT_FOUND' : error = 'Usuário não encontrado';
               break;
            default: error = _authenticationService.errorCode;
          }

          await _dialogService.showDialog(
            title: 'Erro de login',
            description: error,
          );
        }
    }
  }

  
  void handleAfterSignin() {
    Future.delayed(Duration(milliseconds: 1000)).then((f) {
      Modular.to.pushNamed('/login/intro'); 
    });
  }
}
