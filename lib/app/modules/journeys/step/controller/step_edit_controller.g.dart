// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StepEditController on _StepEditControllerBase, Store {
  Computed<File?>? _$selectedInspirationAudioComputed;

  @override
  File? get selectedInspirationAudio => (_$selectedInspirationAudioComputed ??=
          Computed<File?>(() => super.selectedInspirationAudio,
              name: '_StepEditControllerBase.selectedInspirationAudio'))
      .value;
  Computed<File?>? _$selectedMeditationAudioComputed;

  @override
  File? get selectedMeditationAudio => (_$selectedMeditationAudioComputed ??=
          Computed<File?>(() => super.selectedMeditationAudio,
              name: '_StepEditControllerBase.selectedMeditationAudio'))
      .value;
  Computed<String?>? _$nameInspirationAudioFileComputed;

  @override
  String? get nameInspirationAudioFile =>
      (_$nameInspirationAudioFileComputed ??= Computed<String?>(
              () => super.nameInspirationAudioFile,
              name: '_StepEditControllerBase.nameInspirationAudioFile'))
          .value;
  Computed<String?>? _$nameMeditationAudioFileComputed;

  @override
  String? get nameMeditationAudioFile => (_$nameMeditationAudioFileComputed ??=
          Computed<String?>(() => super.nameMeditationAudioFile,
              name: '_StepEditControllerBase.nameMeditationAudioFile'))
      .value;

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

  final _$_selectedInspirationAudioAtom =
      Atom(name: '_StepEditControllerBase._selectedInspirationAudio');

  @override
  File? get _selectedInspirationAudio {
    _$_selectedInspirationAudioAtom.reportRead();
    return super._selectedInspirationAudio;
  }

  @override
  set _selectedInspirationAudio(File? value) {
    _$_selectedInspirationAudioAtom
        .reportWrite(value, super._selectedInspirationAudio, () {
      super._selectedInspirationAudio = value;
    });
  }

  final _$_selectedMeditationAudioAtom =
      Atom(name: '_StepEditControllerBase._selectedMeditationAudio');

  @override
  File? get _selectedMeditationAudio {
    _$_selectedMeditationAudioAtom.reportRead();
    return super._selectedMeditationAudio;
  }

  @override
  set _selectedMeditationAudio(File? value) {
    _$_selectedMeditationAudioAtom
        .reportWrite(value, super._selectedMeditationAudio, () {
      super._selectedMeditationAudio = value;
    });
  }

  final _$selectInspirationAudioAsyncAction =
      AsyncAction('_StepEditControllerBase.selectInspirationAudio');

  @override
  Future<dynamic> selectInspirationAudio() {
    return _$selectInspirationAudioAsyncAction
        .run(() => super.selectInspirationAudio());
  }

  final _$selectMeditationAudioAsyncAction =
      AsyncAction('_StepEditControllerBase.selectMeditationAudio');

  @override
  Future<dynamic> selectMeditationAudio() {
    return _$selectMeditationAudioAsyncAction
        .run(() => super.selectMeditationAudio());
  }

  final _$editStepAsyncAction = AsyncAction('_StepEditControllerBase.editStep');

  @override
  Future<dynamic> editStep(
      {required String journeyId,
      required String title,
      String? stepNumber,
      String? descriptionText,
      String? inspirationText,
      String? meditationText,
      String? practiceText}) {
    return _$editStepAsyncAction.run(() => super.editStep(
        journeyId: journeyId,
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
selectedInspirationAudio: ${selectedInspirationAudio},
selectedMeditationAudio: ${selectedMeditationAudio},
nameInspirationAudioFile: ${nameInspirationAudioFile},
nameMeditationAudioFile: ${nameMeditationAudioFile}
    ''';
  }
}
