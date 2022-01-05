// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_add_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$JourneyAddController on _JourneyAddControllerBase, Store {
  Computed<File?>? _$selectedImageComputed;

  @override
  File? get selectedImage =>
      (_$selectedImageComputed ??= Computed<File?>(() => super.selectedImage,
              name: '_JourneyAddControllerBase.selectedImage'))
          .value;

  final _$_busyAtom = Atom(name: '_JourneyAddControllerBase._busy');

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
      Atom(name: '_JourneyAddControllerBase._selectedImage');

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
      AsyncAction('_JourneyAddControllerBase.selectImage');

  @override
  Future<dynamic> selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  final _$cropImageAsyncAction =
      AsyncAction('_JourneyAddControllerBase.cropImage');

  @override
  Future<void> cropImage() {
    return _$cropImageAsyncAction.run(() => super.cropImage());
  }

  final _$addJourneyAsyncAction =
      AsyncAction('_JourneyAddControllerBase.addJourney');

  @override
  Future<dynamic> addJourney({required String title, String? description}) {
    return _$addJourneyAsyncAction
        .run(() => super.addJourney(title: title, description: description));
  }

  final _$_JourneyAddControllerBaseActionController =
      ActionController(name: '_JourneyAddControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_JourneyAddControllerBaseActionController
        .startAction(name: '_JourneyAddControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_JourneyAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearImage() {
    final _$actionInfo = _$_JourneyAddControllerBaseActionController
        .startAction(name: '_JourneyAddControllerBase.clearImage');
    try {
      return super.clearImage();
    } finally {
      _$_JourneyAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedImage: ${selectedImage}
    ''';
  }
}
