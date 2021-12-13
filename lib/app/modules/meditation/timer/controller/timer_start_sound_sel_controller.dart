import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/meditation/timer/model/timer_sound_model.dart';
import '/app/modules/meditation/timer/repository/timer_sound_repository.dart';
import '/app/shared/services/user_service.dart';
import 'package:mobx/mobx.dart';

import 'timer_service.dart';
part 'timer_start_sound_sel_controller.g.dart';

class TimerStartSoundSelController = _TimerStartSoundSelControllerBase with _$TimerStartSoundSelController;

abstract class _TimerStartSoundSelControllerBase with Store {
  final _userService = Modular.get<UserService>();

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  final List<TimerSound> _timerSounds = TimerSoundRepository.soundRepository;
  List<TimerSound> get timerSounds => _timerSounds;

  @observable
  int _selectedItem = TimerService.selectedStartSoundIndex;
  int get selectedItem => _selectedItem;

  @action
  void setSelectedStartSound(index) {
    _selectedItem = index;
    TimerService.selectedStartSoundIndex = index;
    TimerService.selectedStartSoundTitle = _timerSounds[_selectedItem].title;
    TimerService.soundStartTimer = _timerSounds[_selectedItem];
  }
  
  String? get getUserRole =>
      _userService.currentUser == null ? 'user' : _userService.userRole;

}