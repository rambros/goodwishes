// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_med_add_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DraftMeditationAddController
    on _DraftMeditationAddControllerBase, Store {
  Computed<File?>? _$selectedImageComputed;

  @override
  File? get selectedImage =>
      (_$selectedImageComputed ??= Computed<File?>(() => super.selectedImage,
              name: '_DraftMeditationAddControllerBase.selectedImage'))
          .value;
  Computed<File?>? _$selectedAudioComputed;

  @override
  File? get selectedAudio =>
      (_$selectedAudioComputed ??= Computed<File?>(() => super.selectedAudio,
              name: '_DraftMeditationAddControllerBase.selectedAudio'))
          .value;
  Computed<String?>? _$nameAudioFileComputed;

  @override
  String? get nameAudioFile =>
      (_$nameAudioFileComputed ??= Computed<String?>(() => super.nameAudioFile,
              name: '_DraftMeditationAddControllerBase.nameAudioFile'))
          .value;

  final _$_busyAtom = Atom(name: '_DraftMeditationAddControllerBase._busy');

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

  final _$_selectedImageAtom =
      Atom(name: '_DraftMeditationAddControllerBase._selectedImage');

  @override
  File? get _selectedImage {
    _$_selectedImageAtom.reportRead();
    return super._selectedImage;
  }

  @override
  set _selectedImage(File? value) {
    _$_selectedImageAtom.reportWrite(value, super._selectedImage, () {
      super._selectedImage = value;
    });
  }

  final _$_selectedAudioAtom =
      Atom(name: '_DraftMeditationAddControllerBase._selectedAudio');

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

  final _$selectImageAsyncAction =
      AsyncAction('_DraftMeditationAddControllerBase.selectImage');

  @override
  Future<dynamic> selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  final _$cropImageAsyncAction =
      AsyncAction('_DraftMeditationAddControllerBase.cropImage');

  @override
  Future<void> cropImage() {
    return _$cropImageAsyncAction.run(() => super.cropImage());
  }

  final _$selectAudioAsyncAction =
      AsyncAction('_DraftMeditationAddControllerBase.selectAudio');

  @override
  Future<dynamic> selectAudio() {
    return _$selectAudioAsyncAction.run(() => super.selectAudio());
  }

  final _$addDraftMeditationAsyncAction =
      AsyncAction('_DraftMeditationAddControllerBase.addDraftMeditation');

  @override
  Future<dynamic> addDraftMeditation(
      {required String title,
      String? date,
      List<String>? category,
      bool? featured,
      String? callText,
      String? detailsText,
      String? authorId,
      String? authorText,
      String? authorMusic,
      bool? novaImagem}) {
    return _$addDraftMeditationAsyncAction.run(() => super.addDraftMeditation(
        title: title,
        date: date,
        category: category,
        featured: featured,
        callText: callText,
        detailsText: detailsText,
        authorId: authorId,
        authorText: authorText,
        authorMusic: authorMusic,
        novaImagem: novaImagem));
  }

  final _$_DraftMeditationAddControllerBaseActionController =
      ActionController(name: '_DraftMeditationAddControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_DraftMeditationAddControllerBaseActionController
        .startAction(name: '_DraftMeditationAddControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_DraftMeditationAddControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void clearImage() {
    final _$actionInfo = _$_DraftMeditationAddControllerBaseActionController
        .startAction(name: '_DraftMeditationAddControllerBase.clearImage');
    try {
      return super.clearImage();
    } finally {
      _$_DraftMeditationAddControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedImage: ${selectedImage},
selectedAudio: ${selectedAudio},
nameAudioFile: ${nameAudioFile}
    ''';
  }
}
