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

  final _$_draftStepsAtom =
      Atom(name: '_DraftStepListControllerBase._draftSteps');

  @override
  List<StepModel>? get _draftSteps {
    _$_draftStepsAtom.reportRead();
    return super._draftSteps;
  }

  @override
  set _draftSteps(List<StepModel>? value) {
    _$_draftStepsAtom.reportWrite(value, super._draftSteps, () {
      super._draftSteps = value;
    });
  }

  final _$_draftStepsFilteredAtom =
      Atom(name: '_DraftStepListControllerBase._draftStepsFiltered');

  @override
  List<StepModel>? get _draftStepsFiltered {
    _$_draftStepsFilteredAtom.reportRead();
    return super._draftStepsFiltered;
  }

  @override
  set _draftStepsFiltered(List<StepModel>? value) {
    _$_draftStepsFilteredAtom.reportWrite(value, super._draftStepsFiltered, () {
      super._draftStepsFiltered = value;
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
