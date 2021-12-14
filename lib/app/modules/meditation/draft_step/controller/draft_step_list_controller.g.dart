// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_step_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DraftStepListController on _DraftStepListControllerBase, Store {
  final _$_busyAtom = Atom(name: '_DraftStepListControllerBase._busy');

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

  final _$_DraftStepsAtom =
      Atom(name: '_DraftStepListControllerBase._DraftSteps');

  @override
  List<StepModel>? get _DraftSteps {
    _$_DraftStepsAtom.reportRead();
    return super._DraftSteps;
  }

  @override
  set _DraftSteps(List<StepModel>? value) {
    _$_DraftStepsAtom.reportWrite(value, super._DraftSteps, () {
      super._DraftSteps = value;
    });
  }

  final _$_DraftStepsFilteredAtom =
      Atom(name: '_DraftStepListControllerBase._DraftStepsFiltered');

  @override
  List<StepModel>? get _DraftStepsFiltered {
    _$_DraftStepsFilteredAtom.reportRead();
    return super._DraftStepsFiltered;
  }

  @override
  set _DraftStepsFiltered(List<StepModel>? value) {
    _$_DraftStepsFilteredAtom.reportWrite(value, super._DraftStepsFiltered, () {
      super._DraftStepsFiltered = value;
    });
  }

  final _$_DraftStepListControllerBaseActionController =
      ActionController(name: '_DraftStepListControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_DraftStepListControllerBaseActionController
        .startAction(name: '_DraftStepListControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_DraftStepListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
