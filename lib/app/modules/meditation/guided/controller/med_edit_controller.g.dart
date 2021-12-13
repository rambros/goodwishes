// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'med_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeditationEditController on _MeditationEditControllerBase, Store {
  final _$_busyAtom = Atom(name: '_MeditationEditControllerBase._busy');

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
      Atom(name: '_MeditationEditControllerBase._selectedImage');

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
      AsyncAction('_MeditationEditControllerBase.selectImage');

  @override
  Future<dynamic> selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  final _$cropImageAsyncAction =
      AsyncAction('_MeditationEditControllerBase.cropImage');

  @override
  Future<void> cropImage() {
    return _$cropImageAsyncAction.run(() => super.cropImage());
  }

  final _$editMeditationAsyncAction =
      AsyncAction('_MeditationEditControllerBase.editMeditation');

  @override
  Future<dynamic> editMeditation(
      {required String title,
      List<String>? category,
      String? authorId,
      bool? featured,
      String? callText,
      String? detailsText,
      bool? novaImagem}) {
    return _$editMeditationAsyncAction.run(() => super.editMeditation(
        title: title,
        category: category,
        authorId: authorId,
        featured: featured,
        callText: callText,
        detailsText: detailsText,
        novaImagem: novaImagem));
  }

  final _$_MeditationEditControllerBaseActionController =
      ActionController(name: '_MeditationEditControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_MeditationEditControllerBaseActionController
        .startAction(name: '_MeditationEditControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_MeditationEditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
