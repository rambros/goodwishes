// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StepListController on _StepListControllerBase, Store {
  final _$_busyAtom = Atom(name: '_StepListControllerBase._busy');

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

  final _$_stepsAtom = Atom(name: '_StepListControllerBase._steps');

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

  final _$_stepsFilteredAtom =
      Atom(name: '_StepListControllerBase._stepsFiltered');

  @override
  List<StepModel> get _stepsFiltered {
    _$_stepsFilteredAtom.reportRead();
    return super._stepsFiltered;
  }

  @override
  set _stepsFiltered(List<StepModel> value) {
    _$_stepsFilteredAtom.reportWrite(value, super._stepsFiltered, () {
      super._stepsFiltered = value;
    });
  }

  final _$_StepListControllerBaseActionController =
      ActionController(name: '_StepListControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_StepListControllerBaseActionController.startAction(
        name: '_StepListControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_StepListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
