// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$JourneyListController on _JourneyListControllerBase, Store {
  final _$_busyAtom = Atom(name: '_JourneyListControllerBase._busy');

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

  final _$_journeysAtom = Atom(name: '_JourneyListControllerBase._journeys');

  @override
  List<Journey>? get _journeys {
    _$_journeysAtom.reportRead();
    return super._journeys;
  }

  @override
  set _journeys(List<Journey>? value) {
    _$_journeysAtom.reportWrite(value, super._journeys, () {
      super._journeys = value;
    });
  }

  final _$_JourneyListControllerBaseActionController =
      ActionController(name: '_JourneyListControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_JourneyListControllerBaseActionController
        .startAction(name: '_JourneyListControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_JourneyListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
