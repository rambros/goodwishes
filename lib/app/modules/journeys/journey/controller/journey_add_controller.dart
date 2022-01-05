import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mobx/mobx.dart';

import './../../model/models.dart';
import '../repository/journey_repository.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/image_selector.dart';

part 'journey_add_controller.g.dart';

class JourneyAddController = _JourneyAddControllerBase
    with _$JourneyAddController;

abstract class _JourneyAddControllerBase with Store {
  final _dialogService = Modular.get<DialogService>();
  final _journeyRepository = Modular.get<JourneyRepository>();
  final _cloudStorageService = Modular.get<CloudStorageService>();
  final _imageSelector = Modular.get<ImageSelector>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  bool _newImageSelected = false;
  void setNewImage(bool value) => _newImageSelected = value;

  @observable
  File? _selectedImage;

  @computed
  File? get selectedImage => _selectedImage;

  @action
  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
    }
  }

  @action
  Future<void> cropImage() async {
    var cropped = await ImageCropper.cropImage(
      sourcePath: _selectedImage!.path,
      compressQuality: 70,
      aspectRatio: CropAspectRatio(ratioX: 4.0, ratioY: 3.0),
      //   aspectRatioPresets: [
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   //CropAspectRatioPreset.ratio16x9
      // ],
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Ajuste de imagem',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
        title: 'Image adjustment',
      )
    );
    _selectedImage = cropped ?? _selectedImage;
  }

  @action
  void clearImage() {
    _selectedImage = null;
  }

  Future<bool> imageFileNotOk() async {
    if (selectedImage == null) {
      await _dialogService.showDialog(
        title: 'Was not possible to add this Journey',
        description: 'Must select an image for journey',
      );
      return true;
    } else {
      return false;
    }
  }

  @action
  Future addJourney( {
      required String title,
      String? description,
      }) async {
    setBusy(true);
    
    var imageUrl;
    var imageFileName;

    if (_newImageSelected == true) {
      CloudStorageResult? storageResult;
      storageResult = await _cloudStorageService.uploadImage(
          imageToUpload: _selectedImage!, title: title);
      imageUrl = storageResult?.imageUrl;
      imageFileName = storageResult?.imageFileName;
    }

    var result = await _journeyRepository.addJourney(Journey(
      title: title,
      description: description,
      imageUrl: imageUrl,
      imageFileName: imageFileName,
      stepsTotal: 0,
      status: 'draft',
      steps: <StepModel>[],
    ));

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Was not possible to add this Journey',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Journey added with sucess',
        description: 'Journey added',
      );
    }

    Modular.to.pop();
  }


}
