import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';

import '../repository/draft_med_interface_repository.dart';
import '/app/modules/meditation/guided/model/meditation.dart';

import '/app/shared/author/controller/author_controller.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/utils/explode_title.dart';
import '/app/shared/utils/image_selector.dart';
import '../../../category/category_controller.dart';

part 'draft_med_edit_controller.g.dart';

class DraftMeditationEditController = _DraftMeditationEditControllerBase with _$DraftMeditationEditController;

abstract class _DraftMeditationEditControllerBase with Store {
  final _draftMeditationRepository = Modular.get<IDraftMeditationRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _cloudStorageService = Modular.get<CloudStorageService>();
  final _imageSelector = Modular.get<ImageSelector>();
  final _authorController = Modular.get<AuthorController>();
  final _categoryController = Modular.get<CategoryController>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  void init() {
  }

  bool? get hasCategories => _categoryController.categories == null ? null : true;

  @observable
  File? _selectedImage;

  //@computed
  File? get selectedImage => _selectedImage;

  //@action
  void changeSelectImage(value) => _selectedImage = value;

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
      maxWidth: 300,
      maxHeight: 400 ,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Ajuste de imagem',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
    );
    _selectedImage = cropped ?? _selectedImage;
  }

  Meditation? _edittingMeditation;

  String? imageUrl;
  String? get getImageUrl => imageUrl;
  String? imageFileName;

  @action
  Future editDraftMeditation(
      {required String title,
      //String date,
      List<String>? category,
      String? authorId,
      String? authorText,
      String? authorMusic,
      bool? featured,
      String? callText,
      String? detailsText,
      bool? novaImagem}) async {
    setBusy(true);

    var result;
    var oldImageToDelete;

    if (novaImagem == true) {
      oldImageToDelete = _edittingMeditation!.imageFileName;
      // se é novo ref ou edição da imagem, faz upload para storage
      CloudStorageResult? storageResult;
      storageResult = await _cloudStorageService.uploadImage(
          imageToUpload: _selectedImage!, title: title);
      imageUrl = storageResult?.imageUrl;
      imageFileName = storageResult?.imageFileName;
    } else {
      imageUrl = _edittingMeditation!.imageUrl;
      imageFileName = _edittingMeditation!.imageFileName;
    }

    var titleIndex = explodeTitle(title);
    var authorName = await _authorController.getAuthorName(authorId);


    // está editando Meditationlexão
    var updateMap = {
      'title': title,
      'authorId': authorId,
      'authorName': authorName,
      'authorText': authorText,
      'authorMusic': authorMusic, 
      'imageUrl': imageUrl,
      'imageFileName': imageFileName,
      'featured' : featured,
      'callText': callText,
      'detailsText': detailsText,
      'category': category == null ? [] : List<String>.from(category.map((x) => x)),
      'titleIndex': titleIndex = List<String>.from(titleIndex.map((x) => x)),
    };

    result = await _draftMeditationRepository.updateDraftMeditation(_edittingMeditation, updateMap);

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Não foi possivel atualizar a Meditação',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Meditação atualizada com sucesso',
        description: 'Sua Meditação foi atualizada',
      );

      if (novaImagem == true) {
        await _cloudStorageService.deleteImage(oldImageToDelete); 
      }  
    }

    Modular.to.pop();
  }

  void setEdittingMeditation(Meditation? edittingMeditation) {
    _edittingMeditation = edittingMeditation;
  }

  List<FormBuilderFieldOption> listaCategoriasField(String tipo) {
    return _categoryController.listaCategoriasField(tipo);
  }

  List<DropdownMenuItem<dynamic>> getListAuthors() {
    var listAuthors = _authorController.authors!;
    return listAuthors
        .map(
          (user) => DropdownMenuItem(
            value: user.uid,
            child: Text('${user.fullName}'),
          ),
        )
        .toList();
  }

}
