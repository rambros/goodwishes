// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$JourneyDetailsController on _JourneyDetailsControllerBase, Store {
  final _$_stepsAtom = Atom(name: '_JourneyDetailsControllerBase._steps');

  @override
  List<StepModel> get _steps {
    _$_stepsAtom.reportRead();
    return super._steps;
  }

  @override
  set _steps(List<StepModel> value) {
    _$_stepsAtom.reportWrite(value, super._steps, () {
      super._steps = value;
    });
  }

  final _$_busyAtom = Atom(name: '_JourneyDetailsControllerBase._busy');

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

  final _$startUserJourneyAsyncAction =
      AsyncAction('_JourneyDetailsControllerBase.startUserJourney');

  @override
  Future<dynamic> startUserJourney(Journey journey) {
    return _$startUserJourneyAsyncAction
        .run(() => super.startUserJourney(journey));
  }

  final _$_JourneyDetailsControllerBaseActionController =
      ActionController(name: '_JourneyDetailsControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_JourneyDetailsControllerBaseActionController
        .startAction(name: '_JourneyDetailsControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_JourneyDetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
