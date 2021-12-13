// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthenticationService on _authenticationServiceBase, Store {
  final _$statusAtom = Atom(name: '_authenticationServiceBase.status');

  @override
  AuthenticationStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AuthenticationStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$_fbUserAtom = Atom(name: '_authenticationServiceBase._fbUser');

  @override
  User? get _fbUser {
    _$_fbUserAtom.reportRead();
    return super._fbUser;
  }

  @override
  set _fbUser(User? value) {
    _$_fbUserAtom.reportWrite(value, super._fbUser, () {
      super._fbUser = value;
    });
  }

  final _$_authenticationServiceBaseActionController =
      ActionController(name: '_authenticationServiceBase');

  @override
  void setAuthUser(User? value) {
    final _$actionInfo = _$_authenticationServiceBaseActionController
        .startAction(name: '_authenticationServiceBase.setAuthUser');
    try {
      return super.setAuthUser(value);
    } finally {
      _$_authenticationServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isUserLoggedIn() {
    final _$actionInfo = _$_authenticationServiceBaseActionController
        .startAction(name: '_authenticationServiceBase.isUserLoggedIn');
    try {
      return super.isUserLoggedIn();
    } finally {
      _$_authenticationServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status}
    ''';
  }
}
