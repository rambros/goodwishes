// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SocialLoginController on _SocialLoginControllerBase, Store {
  final _$signInStartGoogleAtom =
      Atom(name: '_SocialLoginControllerBase.signInStartGoogle');

  @override
  bool get signInStartGoogle {
    _$signInStartGoogleAtom.reportRead();
    return super.signInStartGoogle;
  }

  @override
  set signInStartGoogle(bool value) {
    _$signInStartGoogleAtom.reportWrite(value, super.signInStartGoogle, () {
      super.signInStartGoogle = value;
    });
  }

  final _$signInCompleteGoogleAtom =
      Atom(name: '_SocialLoginControllerBase.signInCompleteGoogle');

  @override
  bool get signInCompleteGoogle {
    _$signInCompleteGoogleAtom.reportRead();
    return super.signInCompleteGoogle;
  }

  @override
  set signInCompleteGoogle(bool value) {
    _$signInCompleteGoogleAtom.reportWrite(value, super.signInCompleteGoogle,
        () {
      super.signInCompleteGoogle = value;
    });
  }

  final _$signInStartFbAtom =
      Atom(name: '_SocialLoginControllerBase.signInStartFb');

  @override
  bool get signInStartFb {
    _$signInStartFbAtom.reportRead();
    return super.signInStartFb;
  }

  @override
  set signInStartFb(bool value) {
    _$signInStartFbAtom.reportWrite(value, super.signInStartFb, () {
      super.signInStartFb = value;
    });
  }

  final _$signInCompleteFbAtom =
      Atom(name: '_SocialLoginControllerBase.signInCompleteFb');

  @override
  bool get signInCompleteFb {
    _$signInCompleteFbAtom.reportRead();
    return super.signInCompleteFb;
  }

  @override
  set signInCompleteFb(bool value) {
    _$signInCompleteFbAtom.reportWrite(value, super.signInCompleteFb, () {
      super.signInCompleteFb = value;
    });
  }

  final _$signInStartAppleAtom =
      Atom(name: '_SocialLoginControllerBase.signInStartApple');

  @override
  bool get signInStartApple {
    _$signInStartAppleAtom.reportRead();
    return super.signInStartApple;
  }

  @override
  set signInStartApple(bool value) {
    _$signInStartAppleAtom.reportWrite(value, super.signInStartApple, () {
      super.signInStartApple = value;
    });
  }

  final _$signInCompleteAppleAtom =
      Atom(name: '_SocialLoginControllerBase.signInCompleteApple');

  @override
  bool get signInCompleteApple {
    _$signInCompleteAppleAtom.reportRead();
    return super.signInCompleteApple;
  }

  @override
  set signInCompleteApple(bool value) {
    _$signInCompleteAppleAtom.reportWrite(value, super.signInCompleteApple, () {
      super.signInCompleteApple = value;
    });
  }

  final _$handleGoogleSignInAsyncAction =
      AsyncAction('_SocialLoginControllerBase.handleGoogleSignIn');

  @override
  Future<dynamic> handleGoogleSignIn() {
    return _$handleGoogleSignInAsyncAction
        .run(() => super.handleGoogleSignIn());
  }

  final _$handleAppleLoginAsyncAction =
      AsyncAction('_SocialLoginControllerBase.handleAppleLogin');

  @override
  Future<dynamic> handleAppleLogin() {
    return _$handleAppleLoginAsyncAction.run(() => super.handleAppleLogin());
  }

  final _$handleFacebookLoginAsyncAction =
      AsyncAction('_SocialLoginControllerBase.handleFacebookLogin');

  @override
  Future<dynamic> handleFacebookLogin() {
    return _$handleFacebookLoginAsyncAction
        .run(() => super.handleFacebookLogin());
  }

  final _$exitAppAsyncAction =
      AsyncAction('_SocialLoginControllerBase.exitApp');

  @override
  Future<bool> exitApp() {
    return _$exitAppAsyncAction.run(() => super.exitApp());
  }

  final _$_SocialLoginControllerBaseActionController =
      ActionController(name: '_SocialLoginControllerBase');

  @override
  void handleAnimationGoogle() {
    final _$actionInfo = _$_SocialLoginControllerBaseActionController
        .startAction(name: '_SocialLoginControllerBase.handleAnimationGoogle');
    try {
      return super.handleAnimationGoogle();
    } finally {
      _$_SocialLoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleReverseAnimationGoogle() {
    final _$actionInfo =
        _$_SocialLoginControllerBaseActionController.startAction(
            name: '_SocialLoginControllerBase.handleReverseAnimationGoogle');
    try {
      return super.handleReverseAnimationGoogle();
    } finally {
      _$_SocialLoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleAfterSignupGoogle() {
    final _$actionInfo =
        _$_SocialLoginControllerBaseActionController.startAction(
            name: '_SocialLoginControllerBase.handleAfterSignupGoogle');
    try {
      return super.handleAfterSignupGoogle();
    } finally {
      _$_SocialLoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleAnimationFb() {
    final _$actionInfo = _$_SocialLoginControllerBaseActionController
        .startAction(name: '_SocialLoginControllerBase.handleAnimationFb');
    try {
      return super.handleAnimationFb();
    } finally {
      _$_SocialLoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleReverseAnimationFb() {
    final _$actionInfo =
        _$_SocialLoginControllerBaseActionController.startAction(
            name: '_SocialLoginControllerBase.handleReverseAnimationFb');
    try {
      return super.handleReverseAnimationFb();
    } finally {
      _$_SocialLoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleAfterSignupFb() {
    final _$actionInfo = _$_SocialLoginControllerBaseActionController
        .startAction(name: '_SocialLoginControllerBase.handleAfterSignupFb');
    try {
      return super.handleAfterSignupFb();
    } finally {
      _$_SocialLoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleAnimationApple() {
    final _$actionInfo = _$_SocialLoginControllerBaseActionController
        .startAction(name: '_SocialLoginControllerBase.handleAnimationApple');
    try {
      return super.handleAnimationApple();
    } finally {
      _$_SocialLoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleReverseAnimationApple() {
    final _$actionInfo =
        _$_SocialLoginControllerBaseActionController.startAction(
            name: '_SocialLoginControllerBase.handleReverseAnimationApple');
    try {
      return super.handleReverseAnimationApple();
    } finally {
      _$_SocialLoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleAfterSignupApple() {
    final _$actionInfo = _$_SocialLoginControllerBaseActionController
        .startAction(name: '_SocialLoginControllerBase.handleAfterSignupApple');
    try {
      return super.handleAfterSignupApple();
    } finally {
      _$_SocialLoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
signInStartGoogle: ${signInStartGoogle},
signInCompleteGoogle: ${signInCompleteGoogle},
signInStartFb: ${signInStartFb},
signInCompleteFb: ${signInCompleteFb},
signInStartApple: ${signInStartApple},
signInCompleteApple: ${signInCompleteApple}
    ''';
  }
}
