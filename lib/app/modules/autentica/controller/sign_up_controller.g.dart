// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpController on _SignUpControllerBase, Store {
  final _$signUpStartedAtom = Atom(name: '_SignUpControllerBase.signUpStarted');

  @override
  bool get signUpStarted {
    _$signUpStartedAtom.reportRead();
    return super.signUpStarted;
  }

  @override
  set signUpStarted(bool value) {
    _$signUpStartedAtom.reportWrite(value, super.signUpStarted, () {
      super.signUpStarted = value;
    });
  }

  final _$signUpCompletedAtom =
      Atom(name: '_SignUpControllerBase.signUpCompleted');

  @override
  bool get signUpCompleted {
    _$signUpCompletedAtom.reportRead();
    return super.signUpCompleted;
  }

  @override
  set signUpCompleted(bool value) {
    _$signUpCompletedAtom.reportWrite(value, super.signUpCompleted, () {
      super.signUpCompleted = value;
    });
  }

  final _$handleSignUpwithEmailPasswordAsyncAction =
      AsyncAction('_SignUpControllerBase.handleSignUpwithEmailPassword');

  @override
  Future<dynamic> handleSignUpwithEmailPassword(
      {String? name, String? email, String? pass}) {
    return _$handleSignUpwithEmailPasswordAsyncAction.run(() => super
        .handleSignUpwithEmailPassword(name: name, email: email, pass: pass));
  }

  @override
  String toString() {
    return '''
signUpStarted: ${signUpStarted},
signUpCompleted: ${signUpCompleted}
    ''';
  }
}
