// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_results_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StepResultsController on _StepResultsControllerBase, Store {
  final _$_busyAtom = Atom(name: '_StepResultsControllerBase._busy');

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

  final _$_stepsAtom = Atom(name: '_StepResultsControllerBase._steps');

  @override
  List<StepModel>? get _steps {
    _$_stepsAtom.reportRead();
    return super._steps;
  }

  @override
  set _steps(List<StepModel>? value) {
    _$_stepsAtom.reportWrite(value, super._steps, () {
      super._steps = value;
    });
  }

  final _$_StepResultsControllerBaseActionController =
      ActionController(name: '_StepResultsControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_StepResultsControllerBaseActionController
        .startAction(name: '_StepResultsControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_StepResultsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
