
import '/app/modules/meditation/statistics/model/meditation_log.dart';
import 'package:mobx/mobx.dart';
import 'timer_service.dart';

part 'timer_player_controller.g.dart';

class TimerPlayerController = _TimerPlayerControllerBase with _$TimerPlayerController;

abstract class _TimerPlayerControllerBase with Store {

  MeditationLog? meditationLog;
  
  @observable
  double _volume = 1.0;
  double get volume => _volume; 
  @action
  void setVolume(double value) {
    _volume =  value;
  }

  @observable
  double _speed = 1.0;
  double get speed => _speed; 
  void setSpeed(double value) {
    _speed =  value;
  }

  @observable
  double _position = 0.0;
  double get position => _position; 
  void setPosition(double value) {
    _position =  value;
  }

  @observable
  double _buffering = 0.0;
  double get buffering => _buffering; 
  void setBuffering(double value) {
    _buffering =  value;
  }

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }

  bool get hasStartSound {
    if (TimerService.soundStartTimer != null) {
      if (TimerService.soundStartTimer!.audioFilePath != '') {
        return true;
      }
    }
    return false;
  }

  bool get hasEndSound  {
    if (TimerService.soundEndTimer != null) {
      if (TimerService.soundEndTimer!.audioFilePath != '') {
        return true;
      }
    }
    return false;
  }

  bool get hasBackgroundMusic { 
    if (TimerService.soundBackground != null) {
      if (TimerService.soundBackground!.audioLocation != '') {
        return true;
      }
    }
    return false;
  }

}