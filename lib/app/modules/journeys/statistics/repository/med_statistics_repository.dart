import 'package:shared_preferences/shared_preferences.dart';
import '../model/meditation_log.dart';

class MeditationStatisticsRepository {

  List<MeditationLog> logs = [];


  Future<List<MeditationLog>> getMeditationStatistics () async {
    final _preferences = await SharedPreferences.getInstance();
    var result = _preferences.getString('statistics');
    if (result == null) {
       return [];
    }
    final meditationStatistics = MeditationLog.decodeMeditationStatistics(result);
    return meditationStatistics;
  }


  Future _saveMeditationStatisticsList (listLogs) async {
    final _preferences = await SharedPreferences.getInstance();
    final logs = MeditationLog.encodeMeditationStatistics(listLogs);
    await _preferences.setString('statistics', logs);
  }

  void saveMeditationStatistic (MeditationLog log) async {
    var listLogs = await getMeditationStatistics();
    listLogs.add(log);
    await _saveMeditationStatisticsList(listLogs);
  }


}