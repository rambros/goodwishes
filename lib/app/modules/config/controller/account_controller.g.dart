// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccountController on _AccountControllerBase, Store {
  Computed<File?>? _$selectedImageComputed;

  @override
  File? get selectedImage =>
      (_$selectedImageComputed ??= Computed<File?>(() => super.selectedImage,
              name: '_AccountControllerBase.selectedImage'))
          .value;
  Computed<bool>? _$isUserEmailComputed;

  @override
  bool get isUserEmail =>
      (_$isUserEmailComputed ??= Computed<bool>(() => super.isUserEmail,
              name: '_AccountControllerBase.isUserEmail'))
          .value;
  Computed<bool>? _$userHasNoImageUrlComputed;

  @override
  bool get userHasNoImageUrl => (_$userHasNoImageUrlComputed ??= Computed<bool>(
          () => super.userHasNoImageUrl,
          name: '_AccountControllerBase.userHasNoImageUrl'))
      .value;

  final _$_busyAtom = Atom(name: '_AccountControllerBase._busy');

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
      Atom(name: '_AccountControllerBase._selectedImage');

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
      AsyncAction('_AccountControllerBase.selectImage');

  @override
  Future<dynamic> selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  final _$updateUserAsyncAction =
      AsyncAction('_AccountControllerBase.updateUser');

  @override
  Future<dynamic> updateUser(
      {String? name, String? password, String? email, bool? novaImagem}) {
    return _$updateUserAsyncAction.run(() => super.updateUser(
        name: name, password: password, email: email, novaImagem: novaImagem));
  }

  final _$_AccountControllerBaseActionController =
      ActionController(name: '_AccountControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_AccountControllerBaseActionController.startAction(
        name: '_AccountControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_AccountControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedImage: ${selectedImage},
isUserEmail: ${isUserEmail},
userHasNoImageUrl: ${userHasNoImageUrl}
    ''';
  }
}
