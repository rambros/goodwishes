// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$JourneyEditController on _JourneyEditControllerBase, Store {
  Computed<File?>? _$selectedImageComputed;

  @override
  File? get selectedImage =>
      (_$selectedImageComputed ??= Computed<File?>(() => super.selectedImage,
              name: '_JourneyEditControllerBase.selectedImage'))
          .value;

  final _$_busyAtom = Atom(name: '_JourneyEditControllerBase._busy');

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
      Atom(name: '_JourneyEditControllerBase._selectedImage');

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
      AsyncAction('_JourneyEditControllerBase.selectImage');

  @override
  Future<dynamic> selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  final _$cropImageAsyncAction =
      AsyncAction('_JourneyEditControllerBase.cropImage');

  @override
  Future<void> cropImage() {
    return _$cropImageAsyncAction.run(() => super.cropImage());
  }

  final _$editJourneyAsyncAction =
      AsyncAction('_JourneyEditControllerBase.editJourney');

  @override
  Future<dynamic> editJourney(
      {required String title,
      int? stepNumber,
      String? description,
      String? imageUrl,
      String? imageFileName}) {
    return _$editJourneyAsyncAction.run(() => super.editJourney(
        title: title,
        stepNumber: stepNumber,
        description: description,
        imageUrl: imageUrl,
        imageFileName: imageFileName));
  }

  final _$_JourneyEditControllerBaseActionController =
      ActionController(name: '_JourneyEditControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_JourneyEditControllerBaseActionController
        .startAction(name: '_JourneyEditControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_JourneyEditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearImage() {
    final _$actionInfo = _$_JourneyEditControllerBaseActionController
        .startAction(name: '_JourneyEditControllerBase.clearImage');
    try {
      return super.clearImage();
    } finally {
      _$_JourneyEditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedImage: ${selectedImage}
    ''';
  }
}
