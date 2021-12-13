// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_med_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DraftMeditationEditController
    on _DraftMeditationEditControllerBase, Store {
  final _$_busyAtom = Atom(name: '_DraftMeditationEditControllerBase._busy');

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
      Atom(name: '_DraftMeditationEditControllerBase._selectedImage');

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

  final _$selectImageAsyncAction =
      AsyncAction('_DraftMeditationEditControllerBase.selectImage');

  @override
  Future<dynamic> selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  final _$cropImageAsyncAction =
      AsyncAction('_DraftMeditationEditControllerBase.cropImage');

  @override
  Future<void> cropImage() {
    return _$cropImageAsyncAction.run(() => super.cropImage());
  }

  final _$editDraftMeditationAsyncAction =
      AsyncAction('_DraftMeditationEditControllerBase.editDraftMeditation');

  @override
  Future<dynamic> editDraftMeditation(
      {required String title,
      List<String>? category,
      String? authorId,
      String? authorText,
      String? authorMusic,
      bool? featured,
      String? callText,
      String? detailsText,
      bool? novaImagem}) {
    return _$editDraftMeditationAsyncAction.run(() => super.editDraftMeditation(
        title: title,
        category: category,
        authorId: authorId,
        authorText: authorText,
        authorMusic: authorMusic,
        featured: featured,
        callText: callText,
        detailsText: detailsText,
        novaImagem: novaImagem));
  }

  final _$_DraftMeditationEditControllerBaseActionController =
      ActionController(name: '_DraftMeditationEditControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_DraftMeditationEditControllerBaseActionController
        .startAction(name: '_DraftMeditationEditControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_DraftMeditationEditControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
