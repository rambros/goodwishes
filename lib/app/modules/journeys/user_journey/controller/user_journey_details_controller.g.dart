// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_journey_details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserJourneyDetailsController
    on _UserJourneyDetailsControllerBase, Store {
  final _$_userStepsAtom =
      Atom(name: '_UserJourneyDetailsControllerBase._userSteps');

  @override
  List<UserStep> get _userSteps {
    _$_userStepsAtom.reportRead();
    return super._userSteps;
  }

  @override
  set _userSteps(List<UserStep> value) {
    _$_userStepsAtom.reportWrite(value, super._userSteps, () {
      super._userSteps = value;
    });
  }

  final _$_busyAtom = Atom(name: '_UserJourneyDetailsControllerBase._busy');

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

  final _$_UserJourneyDetailsControllerBaseActionController =
      ActionController(name: '_UserJourneyDetailsControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_UserJourneyDetailsControllerBaseActionController
        .startAction(name: '_UserJourneyDetailsControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_UserJourneyDetailsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
