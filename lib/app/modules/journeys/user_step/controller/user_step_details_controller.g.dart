// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_step_details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStepDetailsController on _UserStepDetailsControllerBase, Store {
  final _$_userStepAtom =
      Atom(name: '_UserStepDetailsControllerBase._userStep');

  @override
  UserStep? get _userStep {
    _$_userStepAtom.reportRead();
    return super._userStep;
  }

  @override
  set _userStep(UserStep? value) {
    _$_userStepAtom.reportWrite(value, super._userStep, () {
      super._userStep = value;
    });
  }

  final _$_busyAtom = Atom(name: '_UserStepDetailsControllerBase._busy');

  @override
  bool get _busy {
    _$_busyAtom.reportRead();
    return super._busy;
  }

  @override
  set _busy(bool value) {
    _$_busyAtom.reportWrite(value, super._busy, () {
      super._busy = value;
    });
  }

  final _$_UserStepDetailsControllerBaseActionController =
      ActionController(name: '_UserStepDetailsControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_UserStepDetailsControllerBaseActionController
        .startAction(name: '_UserStepDetailsControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_UserStepDetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
