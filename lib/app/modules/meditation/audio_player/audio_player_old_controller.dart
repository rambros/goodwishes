
import 'package:mobx/mobx.dart';

 part 'audio_player_old_controller.g.dart';

class AudioPlayerController = _AudioPlayerControllerBase with _$AudioPlayerController;

abstract class _AudioPlayerControllerBase with Store {
  
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

  //int get duration => audioPlayer.playbackEvent.duration.inMilliseconds;

  // @observable
  // AudioPlaybackState _state = AudioPlaybackState.none ;
  // AudioPlaybackState get state => audioPlayer.playbackState;

  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }


}