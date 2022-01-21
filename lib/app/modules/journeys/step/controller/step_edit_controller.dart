// ignore_for_file: unused_field

import 'dart:io';

import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './../../helper/helper.dart';
import '../../journey/repository/journey_repository.dart';
import '/app/modules/journeys/model/step_model.dart';
import '/app/shared/services/cloud_storage_service.dart';
import '/app/shared/services/dialog_service.dart';

part 'step_edit_controller.g.dart';

class StepEditController = _StepEditControllerBase with _$StepEditController;

abstract class _StepEditControllerBase with Store {
  final _journeyRepository = Modular.get<JourneyRepository>();
  final _dialogService = Modular.get<DialogService>();
  final _cloudStorageService = Modular.get<CloudStorageService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) { _busy = value; }

  late StepModel _oldStep;

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

  String? inspirationDuration;
  String? meditationDuration;
  bool _selectedNewInspirationAudioFile = false;
  bool _selectedNewMeditationAudioFile = false;

  @action
  Future selectInspirationAudio() async {
    var tempAudio = await selectAudioFile();
    if (tempAudio != null) {
      _selectedNewInspirationAudioFile = true;
      _selectedInspirationAudio = tempAudio;
      final player = AudioPlayer();
      var _inspirationDuration = await player.setFilePath(_selectedInspirationAudio!.path);
      inspirationDuration = transformMilliseconds(_inspirationDuration!.inMilliseconds);
    }
  }

  @action
  Future selectMeditationAudio() async {
    var tempAudio = await selectAudioFile();
    if (tempAudio != null) {
      _selectedNewMeditationAudioFile = true;
      _selectedMeditationAudio = tempAudio;
      final player = AudioPlayer();
      var _meditationDuration = await player.setFilePath(_selectedMeditationAudio!.path);
      meditationDuration = transformMilliseconds(_meditationDuration!.inMilliseconds);
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
  Future editStep({
      required String journeyId,
      required String title,
      String? stepNumber,
      String? descriptionText,
      String? inspirationText,
      String? meditationText,
      String? practiceText,
      }) async {

    setBusy(true);
    
    CloudStorageAudioResult? storageAudioResult;
    String? inspirationAudioURL;
    String? inspirationFileName;
    String? meditationAudioURL;
    String? meditationFileName;

    if (_selectedNewInspirationAudioFile) {
        storageAudioResult = await _cloudStorageService.uploadAudioFile(_selectedInspirationAudio!);
        inspirationAudioURL = storageAudioResult?.audioUrl;
        inspirationFileName = storageAudioResult?.audioFileName;
    } else {
        inspirationAudioURL = _oldStep.inspirationAudioURL;
        inspirationFileName = _oldStep.inspirationFileName;
        inspirationDuration = _oldStep.inspirationDuration;
    }

    if (_selectedNewMeditationAudioFile) {
        storageAudioResult = await _cloudStorageService.uploadAudioFile(_selectedMeditationAudio!);
        meditationAudioURL = storageAudioResult?.audioUrl;
        meditationFileName = storageAudioResult?.audioFileName;
    } else {
        meditationAudioURL = _oldStep.meditationAudioURL;
        meditationFileName = _oldStep.meditationFileName;
        meditationDuration = _oldStep.meditationDuration;
    }

    var _newStep = StepModel(
      title: title,
      descriptionText: descriptionText,
      stepNumber: int.parse(stepNumber!),
      inspirationAudioURL: inspirationAudioURL,
      inspirationFileName: inspirationFileName,
      inspirationDuration: inspirationDuration,
      inspirationText: inspirationText,
      meditationAudioURL: meditationAudioURL,
      meditationFileName: meditationFileName,
      meditationDuration: meditationDuration,
      meditationText: meditationText,
      practiceText: practiceText,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
    );

      //delete old step
    await _journeyRepository.deleteStep(journeyId: journeyId, step: _oldStep);
    //add new step
    var result = await _journeyRepository.updateStep(journeyId: journeyId, step: _newStep);
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

  void setOldStep(StepModel step) {
    _oldStep = step;
  }

}
