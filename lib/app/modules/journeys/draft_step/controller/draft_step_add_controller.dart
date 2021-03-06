import 'dart:io';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/journeys/model/step_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';

import '../helper/helper_audio_files.dart';
import '../repository/draft_step_interface_repository.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';

part 'draft_step_add_controller.g.dart';

class DraftStepAddController = _DraftStepAddControllerBase
    with _$DraftStepAddController;

abstract class _DraftStepAddControllerBase with Store {
  final _draftStepRepository = Modular.get<IDraftStepRepository>();
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
  File? _selectedInspirationAudio;
  @observable
  File? _selectedMeditationAudio;

  @computed
  File? get selectedInspirationAudio => _selectedInspirationAudio;
  @computed
  File? get selectedMeditationAudio => _selectedMeditationAudio;

  @computed
  String? get nameInspirationAudioFile {
    if (_selectedInspirationAudio != null) {
      return _selectedInspirationAudio!.path.split('/').last;
    } else {
      return null;
    }
  }

  @computed
  String? get nameMeditationAudioFile {
    if (_selectedMeditationAudio != null) {
      return _selectedMeditationAudio!.path.split('/').last;
    } else {
      return null;
    }
  }

  Duration? _inspirationDuration;
  Duration? _meditationDuration;

  @action
  Future selectInspirationAudio() async {
    var tempAudio = await selectAudioFile();
    if (tempAudio != null) {
      _selectedInspirationAudio = tempAudio;
      final player = AudioPlayer();
      _inspirationDuration = await player.setFilePath(_selectedInspirationAudio!.path);
    }
  }

  @action
  Future selectMeditationAudio() async {
    var tempAudio = await selectAudioFile();
    if (tempAudio != null) {
      _selectedMeditationAudio = tempAudio;
      final player = AudioPlayer();
      _meditationDuration = await player.setFilePath(_selectedMeditationAudio!.path);
    }
  }

  Future<bool> audioFileNotOk() async {
    if ((selectedInspirationAudio == null) || (selectedMeditationAudio == null)) {
      await _dialogService.showDialog(
        title: 'Was not possible to crate the step',
        description: 'Need to slect audio file',
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
      int? stepNumber,
      String? descriptionText,
      String? inspirationText,
      String? meditationText,
      String? practiceText,
      }) async {
    setBusy(true);

    CloudStorageAudioResult? storageAudioResult;

    storageAudioResult = await _cloudStorageService.uploadAudioFile(_selectedInspirationAudio!);
    var inspirationAudioURL = storageAudioResult?.audioUrl;
    var inspirationFileName = storageAudioResult?.audioFileName;

    storageAudioResult = await _cloudStorageService.uploadAudioFile(_selectedMeditationAudio!);
    var meditationAudioURL = storageAudioResult?.audioUrl;
    var meditationFileName = storageAudioResult?.audioFileName;

    var result = await _draftStepRepository.addDraftStep(StepModel(
      title: title,
      descriptionText: descriptionText,
      stepNumber: stepNumber ?? 1,
      inspirationAudioURL: inspirationAudioURL,
      inspirationFileName: inspirationFileName,
      inspirationDuration: transformMilliseconds(_inspirationDuration!.inMilliseconds),
      inspirationText: inspirationText,
      meditationAudioURL: meditationAudioURL,
      meditationFileName: meditationFileName,
      meditationDuration: transformMilliseconds(_meditationDuration!.inMilliseconds),
      meditationText: meditationText,
      practiceText: practiceText,
      date: date,
      numPlayed: 2,
      numLiked: 2,
    ));

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Was not possible to add this Step',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Step added with sucess',
        description: 'Step added',
      );
    }

    Modular.to.pop();
  }


}
