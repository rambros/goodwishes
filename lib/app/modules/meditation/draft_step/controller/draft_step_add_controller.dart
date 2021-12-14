import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:goodwishes/app/modules/meditation/guided/model/step_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';

import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';
import '/app/shared/utils/explode_title.dart';
import '../repository/draft_step_interface_repository.dart';

part 'draft_step_add_controller.g.dart';

class DraftStepAddController = _DraftStepAddControllerBase
    with _$DraftStepAddController;

abstract class _DraftStepAddControllerBase with Store {
  final _DraftStepRepository = Modular.get<IDraftStepRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _cloudStorageService = Modular.get<CloudStorageService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
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


  @action
  Future addDraftStep( {
      required String title,
      String? date,
      String? callText,
      String? detailsText,
      }) async {
    setBusy(true);

    var result;
    var audioUrl;
    var audioFileName;
    var numPlayed = 2;
    var numLiked = 2;

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


    result = await _DraftStepRepository.addDraftStep(StepModel(
      title: title,
      titleIndex: titleIndex,
      audioUrl: audioUrl,
      audioFileName: audioFileName,
      audioDuration: _transformMilliseconds(_audioDuration!.inMilliseconds),
      date: date,
      callText: callText,
      detailsText: detailsText,
      numPlayed: numPlayed,
      numLiked: numLiked,
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


  String _transformMilliseconds(int milliseconds) {
    var hundreds = (milliseconds / 10).truncate();
    var seconds = (hundreds / 100).truncate();
    var minutes = (seconds / 60).truncate();

    var minuteStr = (minutes % 60).toString().padLeft(2, '0');
    var secondStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minuteStr:$secondStr';
  }
}
