import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';

import './../../model/models.dart';
import '../repository/journey_repository.dart';
import '/app/shared/utils/image_selector.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';

part 'journey_edit_controller.g.dart';

class JourneyEditController = _JourneyEditControllerBase with _$JourneyEditController;

abstract class _JourneyEditControllerBase with Store {
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
          toolbarTitle: 'Image adjustment',
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

  Journey? _edittingJourney;

  @action
  Future editJourney({
      required String title,
      int? stepNumber,
      String? description,
      String? imageUrl,
      String? imageFileName,
      }) async {

    setBusy(true);
    
    if (_newImageSelected == true) {
      CloudStorageResult? storageResult;
      storageResult = await _cloudStorageService.uploadImage(
          imageToUpload: _selectedImage!, title: title);
      imageUrl = storageResult?.imageUrl;
      imageFileName = storageResult?.imageFileName;
    }

    var result;
    final updateMap = {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'imageFileName': imageFileName,
    };
    result = await _journeyRepository.updateJourney(_edittingJourney, updateMap);
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(
        title: 'Was not possible to update this Journey',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Journey updated with success',
        description: 'Journey updated.',
      );
    }
    Modular.to.pop();
  }

  void setEdittingJourney(Journey? edittingJourney) {
    _edittingJourney = edittingJourney;
  }

}
