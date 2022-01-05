// ignore_for_file: invalid_return_type_for_catch_error, prefer_final_fields

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import '/app/modules/autentica/model/apple_user.dart';
import 'dialog_service.dart';

part 'authentication_service.g.dart';

enum AuthenticationStatus { loading, loggedIn, loggedOut }

class AuthenticationService = _authenticationServiceBase
    with _$AuthenticationService;

abstract class _authenticationServiceBase with Store {
  final _firebaseAuth = auth.FirebaseAuth.instance;
  final _googlSignIn = GoogleSignIn();
  final fbLogin = FacebookLogin();
  final _dialogService = Modular.get<DialogService>();

  _authenticationServiceBase() {
    var _firebaseUser = _firebaseAuth.currentUser;
    setAuthUser(_firebaseUser);
  }

  @observable
  AuthenticationStatus status = AuthenticationStatus.loading;

  @observable
  auth.User? _fbUser;

  auth.User? get currentAuthUser => _fbUser;

  @action
  void setAuthUser(auth.User? value) {
    _fbUser = value;
    status = _fbUser == null
        ? AuthenticationStatus.loggedOut
        : AuthenticationStatus.loggedIn;
  }

  String randomUserImageUrl =
      'https://img.pngio.com/avatar-business-face-people-icon-people-icon-png-512_512.png';

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  bool _userExists = false;
  bool get userExists => _userExists;

  String? _name;
  String? get name => _name;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? timestamp;

  @action
  bool isUserLoggedIn() {
    var user =  _firebaseAuth.currentUser;
    return user != null;
  }

  Future signInWithGoogle() async {
    auth.User? firebaseUser;
    late var authResult;
    late auth.AuthCredential credential;

    final googleUser = await _googlSignIn
        .signIn()
        .catchError((error) => print('error : $error'));

    if (googleUser == null) {
      _hasError = true;
      _errorCode = 'Cancelado pelo usuário';
      return null;
    }

    try {
      final googleAuth = await googleUser.authentication;
      credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      firebaseUser =
          (await _firebaseAuth.signInWithCredential(credential)).user;
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
        rethrow;
      }
      // já tem provider registrado. identifica qual é o provider e faz o login
      final signInMethods =
          await auth.FirebaseAuth.instance.fetchSignInMethodsForEmail(email!);
      if (signInMethods.isNotEmpty) {
        switch (signInMethods[0]) {
          case 'password':
            //solicita password para usuário para fazer o signin
            var resultado = await _dialogService.showInputPassword(
              title: 'Autorização de acesso',
              description:
                  'Você já está cadastrado com email e senha. Para fazer novo login entre com sua senha:',
            );
            //print('Senha do individuo ---> ${resultado.fieldOne}');
            authResult = await _firebaseAuth.signInWithEmailAndPassword(
                email: email!, password: resultado.fieldOne!);
            break;

          case 'facebook.com':
            final facebookLoginResult = await fbLogin
                .logIn(permissions: [
                    FacebookPermission.publicProfile,
                    FacebookPermission.email,
                  ])
                .catchError((error) => print('error: $error'));
            final fbAccessToken = facebookLoginResult.accessToken!;
            final fbCredential =
                auth.FacebookAuthProvider.credential(fbAccessToken.token);
            authResult = await _firebaseAuth.signInWithCredential(fbCredential);
            break;

          default:
            _hasError = true;
            _errorCode = 'cancel';
            rethrow;
        }
      }
      if (authResult.user.email == email) {
        // Now we can link the accounts (facebook e outro provider) together
        await authResult.user.linkWithCredential(credential);
      }
    }  catch (e) {
      _hasError = true;
      _errorCode = 'Erro ';
      rethrow;
    }

    _hasError = false;
    return firebaseUser;
  }

  /// Generates a cryptographically secure random nonce, to be included in a credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<AppleUser> signInWithApple() async {
    UserCredential userCredential;
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    auth.User? firebaseUser;
    late var authResult;
    auth.AuthCredential? credential;
    var appleUser = AppleUser();

    //final appleResult = await AppleSignIn.performRequests([
    //   AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    // ]);

    // switch (appleResult.status) {
    //   case AuthorizationStatus.cancelled:
    //     _hasError = true;
    //     _errorCode = 'Cancelado pelo usuário';
    //     print('User cancelled');
    //     break;

    //   case AuthorizationStatus.error:
    //     _hasError = true;
    //     _errorCode = 'appleLoginResult.errorMessage';
    //     throw (appleResult.error.toString());
    //     break;

    //   case AuthorizationStatus.authorized:
    //     // está ok segue abaixo
    //     break;
    // }

    // if (appleResult.error != null) {
    //   _hasError = true;
    //   print(appleResult.error.toString());
    //   return null;
    // }



    try {
       final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );


      //final appleIdCredential = appleResult.credential;
      //appleUser.credential = appleIdCredential;

      final oauthcredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: rawNonce,
      );

      userCredential = await _firebaseAuth.signInWithCredential(oauthcredential);

      firebaseUser = userCredential.user;
      appleUser.firebaseUser = firebaseUser;
    } on SignInWithAppleException {
      _hasError = true;
       rethrow;
    } on FirebaseAuthException  {
      _hasError = true;
      rethrow;
      // if (e.code == 'user-not-found') {
         
      //    throw AuthError.userNotFound;
      // } else if (e.code == 'wrong-password') {
      //    throw AuthError.invalidEmailAndPasswordCombination;
      // } else if (e.code == 'account-exists-with-different-credential') {
      //    throw AuthError.accountExistsWithDifferentCredential;
      // } else if (e.code == 'invalid-credential') {
      //    throw AuthError.invalidCredential;
      // }
           
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
        rethrow;
      }
      // já tem provider registrado. identifica qual é o provider e faz o login
      final signInMethods =
          await auth.FirebaseAuth.instance.fetchSignInMethodsForEmail(email!);
      if (signInMethods.isNotEmpty) {
        switch (signInMethods[0]) {
          case 'password':
            //solicita password para usuário para fazer o signin
            var resultado = await _dialogService.showInputPassword(
              title: 'Autorização de acesso',
              description:
                  'Você já está cadastrado com email e senha. Para fazer novo login entre com sua senha:',
            );
            //print('Senha do individuo ---> ${resultado.fieldOne}');
            authResult = await _firebaseAuth.signInWithEmailAndPassword(
                email: email!, password: resultado.fieldOne!);
            break;

          case 'facebook.com':
            final facebookLoginResult = await fbLogin
                .logIn(permissions: [
                    FacebookPermission.publicProfile,
                    FacebookPermission.email,
                  ])
                .catchError((error) => print('error: $error'));
            final fbAccessToken = facebookLoginResult.accessToken!;
            final fbCredential =
                auth.FacebookAuthProvider.credential(fbAccessToken.token);
            authResult = await _firebaseAuth.signInWithCredential(fbCredential);
            break;

          case 'google.com':
            final googleUser = await (_googlSignIn
                .signIn()
                .catchError((error) => print('error : $error')));
            final googleAuth = await googleUser?.authentication;
            final googleCredential = auth.GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken,
            );
            authResult =
                await _firebaseAuth.signInWithCredential(googleCredential);
            break;

          default:
            _hasError = true;
            _errorCode = 'cancel';
            rethrow;
        }
      }
      if (authResult.user.email == email) {
        // Now we can link the accounts (facebook e outro provider) together
        await authResult.user.linkWithCredential(credential);
      }
    } catch (e) {
      _hasError = true;
      _errorCode = 'Erro no login com Apple';
      rethrow;
    }
    _hasError = false;
    return appleUser;
  }

  Future loginWithFacebook() async {
    auth.User? _firebaseUser;
    late var authResult;
    final facebookLoginResult = await fbLogin
      .logIn(permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ])
      .catchError((error) => print('error: $error'));

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancel:
        _hasError = true;
        _errorCode = 'Cancelado pelo usuário';
        //throw (facebookLoginResult.errorMessage);
        break;
      case FacebookLoginStatus.error:
        _hasError = true;
        _errorCode = 'facebookLoginResult.errorMessage';
        //throw (facebookLoginResult.errorMessage);
        break;
      case FacebookLoginStatus.success:
        final facebookAccessToken = facebookLoginResult.accessToken!;
        final credential =
            auth.FacebookAuthProvider.credential(facebookAccessToken.token);
        try {
          _firebaseUser =
              (await _firebaseAuth.signInWithCredential(credential)).user;
        } on PlatformException catch (e) {
          if (e.code != 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
            rethrow;
          }
          //Já tem provider registrado, pega o email do facebook com graph API manually
          final httpClient = HttpClient();
          final graphRequest = await httpClient.getUrl(Uri.parse(
              'https://graph.facebook.com/v5.0/me?fields=email&access_token=${facebookLoginResult.accessToken!.token}'));
          final graphResponse = await graphRequest.close();
          final graphResponseJSON =
              json.decode((await graphResponse.transform(utf8.decoder).single));
          final email = graphResponseJSON['email'];

          // identifica qual é o provider e faz o login
          final signInMethods = await auth.FirebaseAuth.instance
              .fetchSignInMethodsForEmail(email);
          if (signInMethods.isNotEmpty) {
            switch (signInMethods[0]) {
              case 'password':
                //pedi password para fazer o signin
                var resultado = await _dialogService.showInputPassword(
                  title: 'Autorização de acesso',
                  description:
                      'Você já está cadastrado com email e senha. Para fazer novo login entre com sua senha:',
                );
                //print('Senha do individuo ---> ${resultado.fieldOne}');
                authResult = await _firebaseAuth.signInWithEmailAndPassword(
                    email: email, password: resultado.fieldOne!);
                break;

              case 'google.com':
                final googleUser = await (_googlSignIn
                    .signIn()
                    .catchError((error) => print('error : $error')));
                final googleAuth = await googleUser?.authentication;
                final googleCredential = auth.GoogleAuthProvider.credential(
                  accessToken: googleAuth?.accessToken,
                  idToken: googleAuth?.idToken,
                );
                authResult =
                    await _firebaseAuth.signInWithCredential(googleCredential);
                break;

              default:
                _hasError = true;
                _errorCode = 'cancel';
                throw facebookLoginResult.error!;
            }
          }

          if (authResult.user.email == email) {
            // Now we can link the accounts (facebook e outro provider) together
            await authResult.user.linkWithCredential(credential);
            _firebaseUser = authResult.user;
          }
        }
        var currentUser = _firebaseAuth.currentUser;
        _hasError = false;
        return currentUser;
    }
    return _firebaseUser;
  }

  Future signUpwithEmailPassword(userEmail, userPassword) async {
    late var authResult;
    //verifica se já tem signin with google ou facebook
    final signInMethods =
        await auth.FirebaseAuth.instance.fetchSignInMethodsForEmail(userEmail);
    if (signInMethods.isNotEmpty) {
      switch (signInMethods[0]) {
        case 'facebook.com':
          final facebookLoginResult = await fbLogin
            .logIn(permissions: [
                FacebookPermission.publicProfile,
                FacebookPermission.email,
              ])
            .catchError((error) => print('error: $error'));
          final fbAccessToken = facebookLoginResult.accessToken!;
          final fbCredential =
              auth.FacebookAuthProvider.credential(fbAccessToken.token);
          authResult = await _firebaseAuth.signInWithCredential(fbCredential);
          break;

        case 'google.com':
          final googleUser = await (_googlSignIn
              .signIn()
              .catchError((error) => print('error : $error')) );
          final googleAuth = await googleUser?.authentication;
          final googleCredential = auth.GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          authResult =
              await _firebaseAuth.signInWithCredential(googleCredential);
          break;

        default:
          _hasError = true;
          _errorCode = 'cancel';
      }
      final credential = auth.EmailAuthProvider.credential(
          email: userEmail, password: userPassword);

      // Now we can link the accounts together e retornar
      try {
        await authResult.user.linkWithCredential(credential);
        return authResult.user;
      } catch (e) {
        _hasError = true;
        _errorCode = 'ERROR_EMAIL_ALREADY_LINKED';
      }
    } else {
      // é o primeiro signin provider - cria usuário
      try {
        final _firebaseUser =
            (await _firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        ))
                .user!;
        _hasError = false;
        return _firebaseUser;
      } catch (e) {
        _hasError = true;
        _errorCode = 'Erro no Cadastro com senha';
      }
    }
  }

  Future signInwithEmailPassword(userEmail, userPassword) async {
    try {
      //final _firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
      //        email: userEmail, password: userPassword)).user!;
      await _firebaseAuth.signInWithEmailAndPassword(
              email: userEmail, password: userPassword);
      final currentUser = _firebaseAuth.currentUser!;
      _uid = currentUser.uid;
      setAuthUser(currentUser);
      //await _userService.populateCurrentUser(currentUser);
      _hasError = false;
      return currentUser;
    } catch (e) {
      _hasError = true;
      _errorCode = 'Erro no login com senha';
      return null;
    }
  }

  Future getTimestamp() async {
    final now = DateTime.now();
    final _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    timestamp = _timestamp;
  }

  Future setSignIn() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('signed in', true);
  }

  void checkSignIn() async {
    final sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed in') ?? false;
  }

  Future logout() async {
    await fbLogin.logOut();
    await _firebaseAuth.signOut();
    await _googlSignIn.signOut();
  }

  Future<String?> updateEmail(String newEmail) async {
    try {
      await _fbUser!.updateEmail(newEmail);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future<String?> updatePassword(String newPassword) async {
    try {
      await _fbUser!.updatePassword(newPassword);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
