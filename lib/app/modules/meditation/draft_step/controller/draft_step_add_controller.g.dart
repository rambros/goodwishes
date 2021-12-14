// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_step_add_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DraftStepAddController on _DraftStepAddControllerBase, Store {
  Computed<File?>? _$selectedAudioComputed;

  @override
  File? get selectedAudio =>
      (_$selectedAudioComputed ??= Computed<File?>(() => super.selectedAudio,
              name: '_DraftStepAddControllerBase.selectedAudio'))
          .value;
  Computed<String?>? _$nameAudioFileComputed;

  @override
  String? get nameAudioFile =>
      (_$nameAudioFileComputed ??= Computed<String?>(() => super.nameAudioFile,
              name: '_DraftStepAddControllerBase.nameAudioFile'))
          .value;

  final _$_busyAtom = Atom(name: '_DraftStepAddControllerBase._busy');

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

  final _$_selectedAudioAtom =
      Atom(name: '_DraftStepAddControllerBase._selectedAudio');

  @override
  File? get _selectedAudio {
    _$_selectedAudioAtom.reportRead();
    return super._selectedAudio;
  }

  @override
  set _selectedAudio(File? value) {
    _$_selectedAudioAtom.reportWrite(value, super._selectedAudio, () {
      super._selectedAudio = value;
    });
  }

  final _$selectAudioAsyncAction =
      AsyncAction('_DraftStepAddControllerBase.selectAudio');

  @override
  Future<dynamic> selectAudio() {
    return _$selectAudioAsyncAction.run(() => super.selectAudio());
  }

  final _$addDraftStepAsyncAction =
      AsyncAction('_DraftStepAddControllerBase.addDraftStep');

  @override
  Future<dynamic> addDraftStep(
      {required String title,
      String? date,
      String? callText,
      String? detailsText}) {
    return _$addDraftStepAsyncAction.run(() => super.addDraftStep(
        title: title,
        date: date,
        callText: callText,
        detailsText: detailsText));
  }

  final _$_DraftStepAddControllerBaseActionController =
      ActionController(name: '_DraftStepAddControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_DraftStepAddControllerBaseActionController
        .startAction(name: '_DraftStepAddControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_DraftStepAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedAudio: ${selectedAudio},
nameAudioFile: ${nameAudioFile}
    ''';
  }
}
