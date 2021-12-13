import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/meditation/timer/model/timer_model.dart';
import '/app/shared/services/user_service.dart';
import 'package:mobx/mobx.dart';

import '../model/timer_model.dart';
import 'timer_service.dart';
part 'timer_controller.g.dart';

class TimerController = _TimerControllerBase with _$TimerController;

abstract class _TimerControllerBase with Store {
  final _userService = Modular.get<UserService>();
  final _silencioBackgroundLocation = 'sounds/background/silencio.mp3';
  final _silencioBackgroundDuration = 30;

  @observable
  int horas = 0;
  @observable
  int minutos = 0;
  @observable
  int segundos = 30;

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  @observable
  int _selectedItem = 0;
  int get selectedItem => _selectedItem;
  @action
  void setSelectedItem(index) {
    _selectedItem = index;
  }

  @action
  String getTitleStartSound() {
    return TimerService.selectedStartSoundTitle ?? 'Nenhum som selecionado';
  }

  @action
  String getTitleEndSound() {
    return TimerService.selectedEndSoundTitle ?? 'Nenhum som selecionado';
  }

  @action
  String getTitle() {
    return TimerService.selectedBackgroundMusicTitle ?? 'Nenhuma selecionada';
  }

  String? get getUserRole =>
      _userService.currentUser == null ? 'user' : _userService.userRole;

  TimerModel get getTimerModel {
    var durationTimer = minutos * 60 + segundos;
    var _soundBackgroundLocation;
    if (TimerService.soundBackground != null) {
      _soundBackgroundLocation =
          TimerService.soundBackground?.audioLocation ?? '';
    } else {
      _soundBackgroundLocation = _silencioBackgroundLocation;
    }
    return TimerModel(
      title: 'Meditação com timer',
      duration: durationTimer, // converter horas e minutos para string
      preparation: '',
      soundStartPath: TimerService.soundStartTimer?.audioFilePath ?? '',
      soundStartDuration: TimerService.soundStartTimer?.audioFileDuration ?? 0,
      soundEndPath: TimerService.soundEndTimer?.audioFilePath ?? '',
      soundEndDuration: TimerService.soundEndTimer?.audioFileDuration ?? 0,
      soundBackgroundLocation: _soundBackgroundLocation,
      soundBackgroundDuration: TimerService.soundBackground?.audioDuration ??
          _silencioBackgroundDuration,
      soundBackgroundType: TimerService.soundBackground?.type ?? '',
    );
  }
}
