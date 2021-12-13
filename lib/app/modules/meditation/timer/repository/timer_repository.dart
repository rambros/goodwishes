import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TimerRepository {

  late SharedPreferences prefs;
  final String timerKey = 'running_timer';
  late DateTime timerStartedAt;
  bool? _timerRunning;
  Duration? elapsed;
  late Duration timerDuration;
  
  
  void _initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    loadTimerFromPrefs();
  }




  void loadTimerFromPrefs() {
      //if (user == null) return;
      var tm = prefs.getString(timerKey);
      if (tm == null) return;
      Map<String, dynamic> tms = json.decode(tm);
      var startedAt = DateTime.fromMillisecondsSinceEpoch(tms['started_at']);
      var rtDuration = Duration(minutes: tms['duration']);

      print(DateTime.now());
      print(startedAt);
      print('difference: ' +
          DateTime.now().difference(startedAt).inSeconds.toString());
      print('total duration: ' + rtDuration.inSeconds.toString());

      var elapsedTime = DateTime.now().difference(startedAt);
      timerStartedAt = startedAt;

      if (elapsedTime.inSeconds < rtDuration.inSeconds) {
        elapsed = elapsedTime;
        _timerRunning = true;
      } else {
          //timerComplete();
      }
}

  Future<bool> _saveTimerToPrefs() async {
    Map<String, dynamic> runningTimer = {
      'duration': timerDuration.inSeconds,
      'started_at': timerStartedAt.millisecondsSinceEpoch,
    };
    return await prefs.setString(timerKey, json.encode(runningTimer));
  }

  _clearTimerFromPrefs() async {
    await prefs.remove(timerKey);
  }
  
}