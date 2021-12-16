import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../helper/helper_audio_files.dart';
import '../repository/draft_step_interface_repository.dart';
import '/app/modules/journey/model/step_model.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';

part 'draft_step_edit_controller.g.dart';

class DraftStepEditController = _DraftStepEditControllerBase with _$DraftStepEditController;

abstract class _DraftStepEditControllerBase with Store {
  final _draftStepRepository = Modular.get<IDraftStepRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _cloudStorageService = Modular.get<CloudStorageService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) { _busy = value; }

  StepModel? _edittingStep;

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
        description: 'Need to select audio file',
      );
      return true;
    } else {
      return false;
    }
  }

  @action
  Future editDraftStep({
      required String title,
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

    var updateMap = {
      'title': title,
      'descriptionText': descriptionText,
      'stepNumber': stepNumber,
      'inspirationAudioURL': inspirationAudioURL,
      'inspirationFileName': inspirationFileName,
      'inspirationDuration': transformMilliseconds(_inspirationDuration!.inMilliseconds),
      'inspirationText': inspirationText,
      'meditationAudioURL': meditationAudioURL,
      'meditationFileName': meditationFileName,
      'meditationDuration': transformMilliseconds(_meditationDuration!.inMilliseconds),
      'meditationText': meditationText,
      'practiceText': practiceText,
    };
    var result = await _draftStepRepository.updateDraftStep(_edittingStep, updateMap);
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Was not possible to update this Step',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Step updated with sucess',
        description: 'Step updated',
      );
    }
    Modular.to.pop();
  }

  void setEdittingStep(StepModel? edittingStep) {
    _edittingStep = edittingStep;
  }

}
