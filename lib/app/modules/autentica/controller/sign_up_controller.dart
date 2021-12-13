import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/autentica/services/internet_service.dart';
import '/app/shared/services/analytics_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/user_service.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/user/user_repository_interface.dart';
import 'package:mobx/mobx.dart';
part 'sign_up_controller.g.dart';

class SignUpController = _SignUpControllerBase with _$SignUpController;

abstract class _SignUpControllerBase with Store {
  final _authenticationService = Modular.get<AuthenticationService>();
  final _is = Modular.get<InternetService>();
  final _dialogService = Modular.get<DialogService>();
  final _userService = Modular.get<UserService>();
  final _userRepository = Modular.get<IUserRepository>();
  final _analyticsService = Modular.get<AnalyticsService>();

  @observable
  bool signUpStarted = false;
  @observable
  bool signUpCompleted = false;

  @action
  Future handleSignUpwithEmailPassword(
      {String? name, String? email, String? pass}) async {
    _is.checkInternet();
    if (_is.hasInternet == false) {
      await _dialogService.showDialog(
        title: 'Sem Internet',
        description: 'Verifique sua conexão de internet',
      );
    } else {
      signUpStarted = true;
      final _firebaseUser =
          await _authenticationService.signUpwithEmailPassword(email, pass);
      if (_authenticationService.hasError == false) {
        var userExists = await _userService.checkUserExists(_firebaseUser);
        if (userExists == false) {
            // create a new user profile on firestore
            var _user = UserApp(
               uid: _firebaseUser.uid,
               loginType: 'email',
               email: email,
               fullName: name,
               userImageUrl:  'https://img2.pngio.com/graphic-design-communication-design-instructional-design-divergent-thinking-png-512_512.jpg',
            );
            await _userRepository.createUser(_user);
            //await _userService.createUser(_currentUser);
        }
        await _userService.populateCurrentUser(_firebaseUser);
        await _authenticationService.setSignIn();
        await _analyticsService.logSignUp('email');
        signUpCompleted = true;
        handleAfterSignup();
      } else {
        signUpStarted = false;
        var error;
        switch (_authenticationService.errorCode) {
          case 'ERROR_WEAK_PASSWORD':
            error = 'Senha muito fraca(fácil)';
            break;
          case 'ERROR_INVALID_EMAIL':
            error = 'Email inválido';
            break;
          case 'ERROR_EMAIL_ALREADY_IN_USE':
            error = 'Email já está em uso';
            break;
          case 'ERROR_EMAIL_ALREADY_LINKED':
            error = 'Email já está em uso';
            break;  
          default:
            error = _authenticationService.errorCode;
        }

        await _dialogService.showDialog(
          title: 'Erro de login',
          description: error,
        );
      }
    }
  }


  void handleAfterSignup() {
    Future.delayed(Duration(milliseconds: 1000)).then((f) {
      Modular.to.pushNamed('/login/intro'); 
    });
  }

  void validatePrivacyConsent(bool? value) async {
    if (value == false) {
          await _dialogService.showDialog(
            title: 'Política de Privacidade',
            description: 'Para se cadastrar no MeditaBK você precisa concordar com nossa Política de Privacidade.',
          );
    }
  }

}

class EmailSuper extends Equatable {
  final String teste;

  EmailSuper(this.teste);

   @override
  List<Object> get props => [teste];

}
