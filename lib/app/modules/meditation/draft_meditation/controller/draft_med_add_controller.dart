import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';

import '/app/modules/category/category_controller.dart';
import '/app/modules/meditation/guided/model/meditation.dart';
import '/app/shared/author/controller/author_controller.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/utils/explode_title.dart';
import '/app/shared/utils/image_selector.dart';
import '../repository/draft_med_interface_repository.dart';

part 'draft_med_add_controller.g.dart';

class Author {
  final String? authorId;
  final String? authorName;

  Author({this.authorId, this.authorName});
}

class DraftMeditationAddController = _DraftMeditationAddControllerBase
    with _$DraftMeditationAddController;

abstract class _DraftMeditationAddControllerBase with Store {
  final _draftMeditationRepository = Modular.get<IDraftMeditationRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _authorController = Modular.get<AuthorController>();
  final _cloudStorageService = Modular.get<CloudStorageService>();
  final _imageSelector = Modular.get<ImageSelector>();
  final _categoryController = Modular.get<CategoryController>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

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
        title: 'Ajuste de imagem',
      )
    );
    _selectedImage = cropped ?? _selectedImage;
  }

  @action
  void clearImage() {
    _selectedImage = null;
  }

  @observable
  File? _selectedAudio;
  Duration? _audioDuration;

  @computed
  File? get selectedAudio => _selectedAudio;

  @computed
  String? get nameAudioFile {
    if (_selectedAudio != null) {
      return _selectedAudio!.path.split('/').last;
    } else {
      return null;
  }
  }

  @action
  Future selectAudio() async {
    var tempAudio = await selectAudioFile();
    if (tempAudio != null) {
      _selectedAudio = tempAudio;

      final player = AudioPlayer();
      _audioDuration = await player.setFilePath(_selectedAudio!.path);
    }
  }

  Future<bool> audioFileNotOk() async {
    if (selectedAudio == null) {
      await _dialogService.showDialog(
        title: 'Não foi possivel criar a Meditação',
        description: 'Necessário selecionar arquivo de áudio',
      );
      return true;
    } else {
      return false;
    }
  }

  Future<bool> imageFileNotOk() async {
    if (selectedImage == null) {
      await _dialogService.showDialog(
        title: 'Não foi possivel criar a Meditação',
        description: 'Necessário selecionar a imagem',
      );
      return true;
    } else {
      return false;
    }
  }

  @action
  Future addDraftMeditation(
      {required String title,
      String? date,
      List<String>? category,
      bool? featured,
      String? callText,
      String? detailsText,
      String? authorId,
      String? authorText,
      String? authorMusic,
      bool? novaImagem}) async {
    setBusy(true);

    var result;
    var imageUrl;
    var imageFileName;

    var audioUrl;
    var audioFileName;
    var numPlayed = 2;
    var numLiked = 2;

    //upload da imagem
    if (novaImagem == true) {
      // se é novo post ou edição da imagem, faz upload para storage
      CloudStorageResult? storageResult;
      storageResult = await _cloudStorageService.uploadImage(
          imageToUpload: _selectedImage!, title: title);
      imageUrl = storageResult?.imageUrl;
      imageFileName = storageResult?.imageFileName;
    }

    //upload do audio
    //if (novoAudio == true) {
    // se é novo post ou edição da imagem, faz upload para storage
    CloudStorageAudioResult? storageAudioResult;
    storageAudioResult = await _cloudStorageService.uploadAudioFile(
        audioToUpload: _selectedAudio!, title: title);
    audioUrl = storageAudioResult?.audioUrl;
    audioFileName = storageAudioResult?.audioFileName;
    //}

    var titleIndex = explodeTitle(title);

    var authorName = await _authorController.getAuthorName(authorId);

    result = await _draftMeditationRepository.addDraftMeditation(Meditation(
      title: title,
      titleIndex: titleIndex,
      authorId: authorId,
      authorName: authorName,
      authorText: authorText,
      authorMusic: authorMusic,
      imageUrl: imageUrl,
      imageFileName: imageFileName,
      audioUrl: audioUrl,
      audioFileName: audioFileName,
      audioDuration: _transformMilliseconds(_audioDuration!.inMilliseconds),
      date: date,
      callText: callText,
      detailsText: detailsText,
      numPlayed: numPlayed,
      numLiked: numLiked,
      category: category,
      featured: featured,
    ));

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Não foi possivel criar a Meditação',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Meditação adicionada com sucesso',
        description: 'Sua Meditação foi adicionada',
      );
    }

    Modular.to.pop();
  }

  bool? get hasCategories =>
      _categoryController.categories == null ? null : true;

  List<FormBuilderFieldOption> listaCategoriasField(String tipo) {
    return _categoryController.listaCategoriasField(tipo);
  }

  Future<File?> selectAudioFile() async {
    File? audioFile;
    try {
        var result = await FilePicker.platform.pickFiles(type: FileType.audio);
        if(result != null) {
             audioFile = File(result.files.single.path!);
        }
    } catch (e) {
      print('Unsupported operation' + e.toString());
      return null;
    }
    return audioFile;
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

 // String _bytesTransferred(StorageTaskSnapshot snapshot) {
 //   return '${snapshot.bytesTransferred}/${snapshot.totalByteCount}';
 // }

  String _transformMilliseconds(int milliseconds) {
    var hundreds = (milliseconds / 10).truncate();
    var seconds = (hundreds / 100).truncate();
    var minutes = (seconds / 60).truncate();

    var minuteStr = (minutes % 60).toString().padLeft(2, '0');
    var secondStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minuteStr:$secondStr';
  }
}
