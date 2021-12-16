// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StepEditController on _StepEditControllerBase, Store {
  final _$_busyAtom = Atom(name: '_StepEditControllerBase._busy');

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

  final _$editStepAsyncAction = AsyncAction('_StepEditControllerBase.editStep');

  @override
  Future<dynamic> editStep(
      {required String title,
      int? stepNumber,
      String? descriptionText,
      String? inspirationText,
      String? meditationText,
      String? practiceText}) {
    return _$editStepAsyncAction.run(() => super.editStep(
        title: title,
        stepNumber: stepNumber,
        descriptionText: descriptionText,
        inspirationText: inspirationText,
        meditationText: meditationText,
        practiceText: practiceText));
  }

  final _$_StepEditControllerBaseActionController =
      ActionController(name: '_StepEditControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_StepEditControllerBaseActionController.startAction(
        name: '_StepEditControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_StepEditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
