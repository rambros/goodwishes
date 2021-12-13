import '/app/modules/meditation/timer/model/timer_sound_model.dart';

import '../model/timer_music_model.dart';

class TimerService {

  static String? selectedBackgroundMusicTitle;
  static String? selectedStartSoundTitle;
  static String? selectedEndSoundTitle;
  
  static TimerMusic? soundBackground;
  static TimerSound? soundEndTimer;
  static TimerSound? soundStartTimer;

  static int selectedBackgroundMusicIndex = 0;
  static int selectedStartSoundIndex = 0;
  static int selectedEndMusicIndex = 0;
  
}