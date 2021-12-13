import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '/app/modules/autentica/model/apple_user.dart';
import '/app/modules/autentica/services/internet_service.dart';
import '/app/shared/services/analytics_service.dart';
import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/services/user_service.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/user/user_repository_interface.dart';

part 'social_login_controller.g.dart';

class SocialLoginController = _SocialLoginControllerBase
    with _$SocialLoginController;

abstract class _SocialLoginControllerBase with Store {
  final _authenticationService = Modular.get<AuthenticationService>();
  final _internetService = Modular.get<InternetService>();
  final _dialogService = Modular.get<DialogService>();
  final _userService = Modular.get<UserService>();
  final _userRepository = Modular.get<IUserRepository>();
  final _analyticsService = Modular.get<AnalyticsService>();

  @observable
  bool signInStartGoogle = false;
  double leftPaddingGoogle = 20;
  double rightPaddingGoogle = 20;
  @observable
  bool signInCompleteGoogle = false;

  @observable
  bool signInStartFb = false;
  double leftPaddingFb = 10;
  double rightPaddingFb = 10;
  @observable
  bool signInCompleteFb = false;

  @observable
  bool signInStartApple = false;
  double leftPaddingApple = 10;
  double rightPaddingApple = 10;
  @observable
  bool signInCompleteApple = false;

  void init() {
    signInStartGoogle = false;
    signInCompleteGoogle = false;
    signInStartFb = false;
    signInCompleteFb = false;
    signInStartApple = false;
    signInCompleteApple = false;
  }

  void gotoSignInWithEmail() {
    Modular.to.pushNamed('/login/signin');
  }

  @action
  Future handleGoogleSignIn() async {
    _internetService.checkInternet();
    if (_internetService.hasInternet == false) {
      await _dialogService.showDialog(
        title: 'Sem Internet',
        description: 'Verifique sua conexão de internet',
      );
      return;
    }

    handleAnimationGoogle();
    final _firebaseUser = await _authenticationService.signInWithGoogle();
    if (_authenticationService.hasError == true) {
      await _dialogService.showDialog(
        title: 'Erro',
        //description: 'Alguma coisa está errada. Por favor tente de novo.',
        description: _authenticationService.errorCode,
      );
      signInStartGoogle = false;
      handleReverseAnimationGoogle();
    } else {
      var userExists = await _userService.checkUserExists(_firebaseUser);
      if (userExists == false) {
        await _userService.createUser(_firebaseUser);
        // create a new user profile on firestore
        var _currentUser = UserApp(
          uid: _firebaseUser.uid,
          loginType: 'Google',
          email: _firebaseUser.email,
          fullName: _firebaseUser.displayName,
          userImageUrl: _firebaseUser.photoUrl,
        );
        await _userRepository.createUser(_currentUser);
      }

      await _userService.populateCurrentUser(_firebaseUser);
      await _authenticationService.setSignIn();
      await _analyticsService.setUserProperties(userId: _firebaseUser.uid);
      await _analyticsService.logSignUp('google');
      signInCompleteGoogle = true;
      handleAfterSignupGoogle();
    }
  }

  // Determine if Apple SignIn is available
  Future<bool> get appleSignInAvailable => SignInWithApple.isAvailable();

  @action
  Future handleAppleLogin() async {
    _internetService.checkInternet();
    if (_internetService.hasInternet == false) {
      await _dialogService.showDialog(
        title: 'Sem Internet',
        description: 'Verifique sua conexão de internet',
      );
      return;
    }

    handleAnimationApple();
    User? _firebaseUser;
    var appleUser = AppleUser();
    try {
      appleUser = await _authenticationService.signInWithApple();
      _firebaseUser = appleUser.firebaseUser;
    } catch (e) {
      print(e);
    }

    if (_authenticationService.hasError == true) {
      await _dialogService.showDialog(
        title: 'Erro',
        description: 'Erro no login do Apple! Por favor tente com o Google',
      );
      signInStartFb = false;
      handleReverseAnimationApple();
    } else {
      var userExists = await _userService.checkUserExists(_firebaseUser);
      if (userExists == false) {
        // create a new user profile on firestore
        var _currentUser = UserApp(
          uid: _firebaseUser!.uid,
          loginType: 'Apple',
          email: _firebaseUser.email,
          fullName:
              '${appleUser.credential.fullName.givenName} ${appleUser.credential.fullName.familyName}',
          //userImageUrl: _firebaseUser.photoURL,
        );
        await _userRepository.createUser(_currentUser);
        //await _userService.createUser(_firebaseUser);
      }
      await _userService.populateCurrentUser(_firebaseUser);
      await _authenticationService.setSignIn();
      await _analyticsService.setUserProperties(userId: _firebaseUser!.uid);
      await _analyticsService.logSignUp('apple');
      signInCompleteFb = true;
      handleAfterSignupApple();
    }
  }

  @action
  Future handleFacebookLogin() async {
    _internetService.checkInternet();
    if (_internetService.hasInternet == false) {
      await _dialogService.showDialog(
        title: 'Sem Internet',
        description: 'Verifique sua conexão de internet',
      );
      return;
    }

    handleAnimationFb();
    final _firebaseUser = await _authenticationService.loginWithFacebook();
    if (_authenticationService.hasError == true) {
      await _dialogService.showDialog(
        title: 'Erro',
        description: 'Erro no login do Facebook! Por favor tente com o Google',
      );
      signInCompleteFb = false;
      handleReverseAnimationFb();
    } else {
      var userExists = await _userService.checkUserExists(_firebaseUser);
      if (userExists == false) {
        // create a new user profile on firestore
        var _currentUser = UserApp(
          uid: _firebaseUser.uid,
          loginType: 'Facebook',
          email: _firebaseUser.email,
          fullName: _firebaseUser.displayName,
          userImageUrl: _firebaseUser.photoUrl,
        );
        await _userRepository.createUser(_currentUser);
        //await _userService.createUser(_firebaseUser);
      }

      await _userService.populateCurrentUser(_firebaseUser);
      await _authenticationService.setSignIn();
      await _analyticsService.setUserProperties(userId: _firebaseUser.uid);
      await _analyticsService.logSignUp('facebook');
      signInCompleteFb = true;
      handleAfterSignupFb();
    }
  }

  /// Google Signin
  @action
  void handleAnimationGoogle() {
    leftPaddingGoogle = 10;
    rightPaddingGoogle = 10;
    signInStartGoogle = true;
  }

  @action
  void handleReverseAnimationGoogle() {
    leftPaddingGoogle = 20;
    rightPaddingGoogle = 20;
    signInStartGoogle = false;
  }

  @action
  void handleAfterSignupGoogle() {
    leftPaddingGoogle = 20;
    rightPaddingGoogle = 20;
    Future.delayed(Duration(milliseconds: 1000)).then((f) {
      Modular.to.pushReplacementNamed('/login/intro');
    });
  }

  /// Facebook Login
  @action
  void handleAnimationFb() {
    leftPaddingFb = 5;
    rightPaddingFb = 5;
    signInStartFb = true;
  }

  @action
  void handleReverseAnimationFb() {
    leftPaddingFb = 10;
    rightPaddingFb = 10;
    signInStartFb = false;
  }

  @action
  void handleAfterSignupFb() {
    leftPaddingFb = 10;
    rightPaddingFb = 10;
    Future.delayed(Duration(milliseconds: 1000)).then((f) {
      Modular.to.pushNamed('/login/intro');
    });
  }

  /// Apple Login
  @action
  void handleAnimationApple() {
    leftPaddingApple = 5;
    rightPaddingApple = 5;
    signInStartApple = true;
  }

  @action
  void handleReverseAnimationApple() {
    leftPaddingApple = 10;
    rightPaddingApple = 10;
    signInStartApple = false;
  }

  @action
  void handleAfterSignupApple() {
    leftPaddingApple = 10;
    rightPaddingApple = 10;
    Future.delayed(Duration(milliseconds: 1000)).then((f) {
      Modular.to.pushNamed('/login/intro');
    });
  }

  @action
  Future<bool> exitApp() async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Você tem certeza que quer sair do app?',
      description: 'Você realmente quer sair e fechar o app?',
      confirmationTitle: 'Sim',
      cancelTitle: 'Não',
    );

    if (dialogResponse.confirmed!) {
      await SystemNavigator.pop();
      return true;
    } else {
      return false;
    }
  }
}
