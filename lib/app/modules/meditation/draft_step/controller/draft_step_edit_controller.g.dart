// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_step_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DraftStepEditController on _DraftStepEditControllerBase, Store {
  final _$_busyAtom = Atom(name: '_DraftStepEditControllerBase._busy');

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

  final _$editDraftStepAsyncAction =
      AsyncAction('_DraftStepEditControllerBase.editDraftStep');

  @override
  Future<dynamic> editDraftStep(
      {required String title, String? callText, String? detailsText}) {
    return _$editDraftStepAsyncAction.run(() => super.editDraftStep(
        title: title, callText: callText, detailsText: detailsText));
  }

  final _$_DraftStepEditControllerBaseActionController =
      ActionController(name: '_DraftStepEditControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_DraftStepEditControllerBaseActionController
        .startAction(name: '_DraftStepEditControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_DraftStepEditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
