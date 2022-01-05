import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/meditation_log.dart';
import '../repository/med_statistics_repository.dart';

part 'statistics_controller.g.dart';

class DailyLog {
  DateTime? day;
  int? totalTime;
  int? timerTime;
  int? medTime;
  int? medSession;
  int? timerSession;
  int? sessions;

  DailyLog({
    this.day,
    this.totalTime,
    this.timerTime,
    this.medTime,
    this.medSession,
    this.timerSession,
    this.sessions,
  });

  @override
  int? compareTo(other) {
    if (day == null || other == null) {
      return null;
    }
    if (day!.isBefore(other.day) ) {
      return 1;
    }

    if (day!.isAfter(other.day)) {
      return -1;
    }

    if ((day!.day == other.day) && (day!.month == other.month) && (day!.year == other.year)) {
      return 0;
    }

    return null;
  }
}

class WeeklyLog {
  DateTime? week;
  int? totalTime;
  int? timerTime;
  int? medTime;
  int? sessions;
  int? medSession;
  int? timerSession;
  
  WeeklyLog({
    this.week,
    this.totalTime,
    this.timerTime,
    this.medTime,
    this.sessions,
    this.medSession,
    this.timerSession,
  });
}

class MonthlyLog {
  String? month;
  int? totalTime;
  int? timerTime;
  int? medTime;
  int? sessions;
  int? medSession;
  int? timerSession;
  
  MonthlyLog({
    this.month,
    this.totalTime,
    this.timerTime,
    this.medTime,
    this.sessions,
    this.medSession,
    this.timerSession,
  });
}

class YearlyLog {
  int? year;
  int? totalTime;
  int? timerTime;
  int? medTime;
  int? sessions;
  int? medSession;
  int? timerSession;
  
  YearlyLog({
    this.year,
    this.totalTime,
    this.timerTime,
    this.medTime,
    this.sessions,
    this.medSession,
    this.timerSession,
  });
}

class StatisticsController = _StatisticsControllerBase with _$StatisticsController;

abstract class _StatisticsControllerBase with Store {

  final _medStatsRepository = Modular.get<MeditationStatisticsRepository>();

  List<MeditationLog> listLogsFromRepository = [];
  List<DailyLog?> listDailyLog = List.filled(14, DailyLog()) ;    // 14 days
  List<WeeklyLog?> listWeeklyLog = List.filled(12, WeeklyLog());   // 12 weeks
  List<MonthlyLog?> listMonthlyLog = List.filled(12, MonthlyLog());// 12 months
  
  var numYears = 4;
  late List<YearlyLog?> listYearlyLog;  

  /// Day
  List<ChartSeries<DailyLog?, DateTime>>? _seriesTimeListD;
  List<ChartSeries<DailyLog?, DateTime>>? _seriesSessionsListD;
  
  @observable
  var _totalTimeD = 0;
  var _totalTimeTimerD = 0;
  var _totalTimeMedD = 0;
  var _dailyAverageTimeD = 0;
  var _averageSessionTimeD = 0;
  int? _longestSessionD = 0;
  var _numberSessionsD = 0;
  var _numberTimerSessionsD = 0;
  var _numberMedSessionsD = 0;
  var _dailyAverageSessionsD = 0.0;
  int? _greaterNumDailySessionsD = 0;
  var _greaterSequenceOfDaysWithSessionD = 0;
  var _actualSequenceOfDaysWithSessionD = 0;


  /// Week
  List<ChartSeries<WeeklyLog?, String>>? _seriesTimeListW;
  List<ChartSeries<WeeklyLog?, String>>? _seriesSessionsListW;

  @observable
  var _totalTimeW = 0;
  var _totalTimeTimerW = 0;
  var _totalTimeMedW = 0;
  var _dailyAverageTimeW = 0;
  var _averageSessionTimeW = 0;
  int? _longestSessionW = 0;
  var _numberSessionsW = 0;
  var _numberTimerSessionsW = 0;
  var _numberMedSessionsW = 0;
  var _dailyAverageSessionsW = 0.0;
  int? _greaterNumDailySessionsW = 0;
  var _greaterSequenceOfDaysWithSessionW = 0;
  var _actualSequenceOfDaysWithSessionW = 0;

  /// Month
  List<ChartSeries<MonthlyLog?, String>>? _seriesTimeListM;
  List<ChartSeries<MonthlyLog?, String>>? _seriesSessionsListM;

  @observable
  var _totalTimeM = 0;
  var _totalTimeTimerM = 0;
  var _totalTimeMedM = 0;
  var _dailyAverageTimeM = 0;
  var _averageSessionTimeM = 0;
  int? _longestSessionM = 0;
  var _numberSessionsM = 0;
  var _numberTimerSessionsM = 0;
  var _numberMedSessionsM = 0;
  var _dailyAverageSessionsM = 0.0;
  int? _greaterNumDailySessionsM = 0;
  var _greaterSequenceOfDaysWithSessionM = 0;
  var _actualSequenceOfDaysWithSessionM = 0;


  /// year
  List<ChartSeries<YearlyLog?, String>>? _seriesTimeListY;
  List<ChartSeries<YearlyLog?, String>>? _seriesSessionsListY;
  
  @observable
  var _totalTimeY = 0;
  var _totalTimeTimerY = 0;
  var _totalTimeMedY = 0;
  var _dailyAverageTimeY = 0;
  var _averageSessionTimeY = 0;
  int? _longestSessionY = 0;
  var _numberSessionsY = 0;
  var _numberTimerSessionsY = 0;
  var _numberMedSessionsY = 0;
  var _dailyAverageSessionsY = 0.0;
  int? _greaterNumDailySessionsY = 0;
  var _greaterSequenceOfDaysWithSessionY = 0;
  var _actualSequenceOfDaysWithSessionY = 0;

  void init() async { 
     listLogsFromRepository = await _medStatsRepository.getMeditationStatistics();
    _calculateStatisticsD(listLogsFromRepository);
    _calculateStatisticsW(listLogsFromRepository);
    _calculateStatisticsM(listLogsFromRepository);
    _calculateStatisticsY(listLogsFromRepository);
  }

  @computed
  String get totalTimeD => _roundTime(_totalTimeD);
  String get totalTimeTimerD => _roundTime(_totalTimeTimerD);
  String get totalTimeMedD => _roundTime(_totalTimeMedD);
  String get dailyAverageTimeD => _roundTime(_dailyAverageTimeD);
  String get averageSessionTimeD => _roundTime(_averageSessionTimeD);
  String get longestSessionD => _roundTime(_longestSessionD!);
  String get numberSessionsD => _numberSessionsD.toString();
  String get numberTimerSessionsD => _numberTimerSessionsD.toString();
  String get numberMedSessionsD => _numberMedSessionsD.toString();
  String get dailyAverageSessionsD => _dailyAverageSessionsD.toStringAsFixed(1);
  String get greaterNumDailySessionsD => _greaterNumDailySessionsD.toString();
  String get greaterSequenceOfDaysWithSessionD => _greaterSequenceOfDaysWithSessionD.toString();
  String get actualSequenceOfDaysWithSessionD => _actualSequenceOfDaysWithSessionD.toString();

  List<ChartSeries>? get seriesTimeListD => _seriesTimeListD;
  List<ChartSeries>? get seriesSessionsListD => _seriesSessionsListD;

  @computed
  String get totalTimeW => _roundTime(_totalTimeW);
  String get totalTimeTimerW => _roundTime(_totalTimeTimerW);
  String get totalTimeMedW => _roundTime(_totalTimeMedW);
  String get dailyAverageTimeW => _roundTime(_dailyAverageTimeW);
  String get averageSessionTimeW => _roundTime(_averageSessionTimeW);
  String get longestSessionW => _roundTime(_longestSessionW!);
  String get numberSessionsW => _numberSessionsW.toString();
  String get numberTimerSessionsW => _numberTimerSessionsW.toString();
  String get numberMedSessionsW => _numberMedSessionsW.toString();
  String get dailyAverageSessionsW => _dailyAverageSessionsW.toStringAsFixed(1);
  String get greaterNumDailySessionsW => _greaterNumDailySessionsW.toString();
  String get greaterSequenceOfDaysWithSessionW => _greaterSequenceOfDaysWithSessionW.toString();
  String get actualSequenceOfDaysWithSessionW => _actualSequenceOfDaysWithSessionW.toString();

  List<ChartSeries>? get seriesTimeListW => _seriesTimeListW;
  List<ChartSeries>? get seriesSessionsListW => _seriesSessionsListW;

  @computed
  String get totalTimeM => _roundTime(_totalTimeM);
  String get totalTimeTimerM => _roundTime(_totalTimeTimerM);
  String get totalTimeMedM => _roundTime(_totalTimeMedM);
  String get dailyAverageTimeM => _roundTime(_dailyAverageTimeM);
  String get averageSessionTimeM => _roundTime(_averageSessionTimeM);
  String get longestSessionM => _roundTime(_longestSessionM!);
  String get numberSessionsM => _numberSessionsM.toString();
  String get numberTimerSessionsM => _numberTimerSessionsM.toString();
  String get numberMedSessionsM => _numberMedSessionsM.toString();
  String get dailyAverageSessionsM => _dailyAverageSessionsM.toStringAsFixed(1);
  String get greaterNumDailySessionsM => _greaterNumDailySessionsM.toString();
  String get greaterSequenceOfDaysWithSessionM => _greaterSequenceOfDaysWithSessionM.toString();
  String get actualSequenceOfDaysWithSessionM => _actualSequenceOfDaysWithSessionM.toString();

  List<ChartSeries>? get seriesTimeListM => _seriesTimeListM;
  List<ChartSeries>? get seriesSessionsListM => _seriesSessionsListM;

  @computed
  String get totalTimeY => _roundTime(_totalTimeY);
  String get totalTimeTimerY => _roundTime(_totalTimeTimerY);
  String get totalTimeMedY => _roundTime(_totalTimeMedY);
  String get dailyAverageTimeY => _roundTime(_dailyAverageTimeY);
  String get averageSessionTimeY => _roundTime(_averageSessionTimeY);
  String get longestSessionY => _roundTime(_longestSessionY!);
  String get numberSessionsY => _numberSessionsY.toString();
  String get numberTimerSessionsY => _numberTimerSessionsY.toString();
  String get numberMedSessionsY => _numberMedSessionsY.toString();
  String get dailyAverageSessionsY => _dailyAverageSessionsY.toStringAsFixed(1);
  String get greaterNumDailySessionsY => _greaterNumDailySessionsY.toString();
  String get greaterSequenceOfDaysWithSessionY => _greaterSequenceOfDaysWithSessionY.toString();
  String get actualSequenceOfDaysWithSessionY => _actualSequenceOfDaysWithSessionY.toString();

  List<ChartSeries>? get seriesTimeListY => _seriesTimeListY;
  List<ChartSeries>? get seriesSessionsListY => _seriesSessionsListY;


  List<MeditationLog> _getLastDays(List<MeditationLog> _logs) {
    var now = DateTime.now();
    var _Days = now.subtract(const Duration(days: 13, hours: 0));  // [0..13] = 14 dias
    var tempLogs = _logs.where((log) => log.date!.isAfter(_Days)).toList();
    return tempLogs;
  }

  void _calculateStatisticsD(List<MeditationLog> listLogs) {

      var daySessionTemp = 0 ; 
      var monthSessionTemp = 0; 
      var yearSessionTemp = 0;
      var numDaysWithSession = 0;

      if (listLogs.isEmpty) {
            return;
      }

      listLogs = _getLastDays(listLogs);

      for (var i = 0; i < listDailyLog.length; i++) {
        listDailyLog[i] = DailyLog( 
              day: DateTime.now().subtract(Duration(days: i)),
              totalTime: 0,
              timerTime: 0,
              medTime: 0,
              sessions: 0,
              medSession:0,
              timerSession: 0,
        );
      }


      listLogs.forEach((log) {
            _totalTimeD = _totalTimeD + log.duration!;

            if (log.type == 'timer') {
               _totalTimeTimerD = _totalTimeTimerD + log.duration!;
               _numberTimerSessionsD++;
            } else {
               _totalTimeMedD = _totalTimeMedD + log.duration!;
              _numberMedSessionsD++; 
            }

            if ( log.date!.year  != yearSessionTemp  || 
                 log.date!.month != monthSessionTemp ||
                 log.date!.day != daySessionTemp) {
                    numDaysWithSession++;
                    daySessionTemp = log.date!.day;
                    monthSessionTemp = log.date!.month;
                    yearSessionTemp = log.date!.year;
            } 
            
            // insert values in the day that is in list -> search in day atribute
            var index = listDailyLog.indexWhere((value) => value!.day!.day == log.date!.day && 
                                               value.day!.month == log.date!.month && 
                                               value.day!.year == log.date!.year);

            listDailyLog[index]!.totalTime = listDailyLog[index]!.totalTime! + log.duration!;
            listDailyLog[index]!.medTime = log.type == 'guided' ? listDailyLog[index]!.medTime! + log.duration! : listDailyLog[index]!.medTime;
            listDailyLog[index]!.timerTime = log.type == 'timer' ? listDailyLog[index]!.timerTime! + log.duration! : listDailyLog[index]!.timerTime;
            listDailyLog[index]!.medSession = log.type == 'guided' ? listDailyLog[index]!.medSession! + 1 : listDailyLog[index]!.medSession;
            listDailyLog[index]!.timerSession = log.type == 'timer' ? listDailyLog[index]!.timerSession! + 1 : listDailyLog[index]!.timerSession!;
            listDailyLog[index]!.sessions = listDailyLog[index]!.sessions! + 1;

       });
       _numberSessionsD = listLogs.length;
       _averageSessionTimeD = _totalTimeD ~/ _numberSessionsD; 
       _dailyAverageTimeD = _totalTimeD ~/ numDaysWithSession;
       _dailyAverageSessionsD =_numberSessionsD / numDaysWithSession;

      listLogs.sort((a, b) => b.duration!.compareTo(a.duration!));
      _longestSessionD = listLogs[0].duration;

      // calculate the sequences of days with sessions
      var _numDay = 0;
      var isSequence = false;
      var daysInSequence = 0;
      var listSequences = []; 
      var isSequenceActive = false; 
      while (_numDay < listDailyLog.length) {
        if (listDailyLog[_numDay]!.sessions! > 0 ) {
            daysInSequence++;
            isSequence = true;
            if (listDailyLog[_numDay]!.day!.day == DateTime.now().day && 
                listDailyLog[_numDay]!.day!.month == DateTime.now().month && 
                listDailyLog[_numDay]!.day!.year == DateTime.now().year )  {
                 isSequenceActive = true;
            };
        } else {
          if (isSequence) { 
            listSequences.add(daysInSequence);
          }
          daysInSequence = 0;
          isSequence = false;
        }
        _numDay++;
      }

      if (isSequenceActive) {
        _actualSequenceOfDaysWithSessionD = listSequences[0] ?? 1;
      } else {
        _actualSequenceOfDaysWithSessionD = 0;
      }

      listSequences.sort((a,b) => b.compareTo(a));
      _greaterSequenceOfDaysWithSessionD = listSequences[0];

      var listTempTest = List.from(listDailyLog);

      listTempTest.sort((a,b) => b.sessions.compareTo(a.sessions));
      _greaterNumDailySessionsD = listTempTest[0].sessions;

      // reorganize for graphics in UI
      //listyLog.sort((a,b) => b.compareTo(a));

      //_seriesTimeListD = List<ChartSeries<DailyLog, DateTime>>();
      _seriesTimeListD = <ChartSeries<DailyLog?, DateTime>>[
              StackedColumnSeries<DailyLog?, DateTime>(
                  name: 'Timer',
                  dataSource: listDailyLog,
                  xValueMapper: (DailyLog? log, _) => log!.day,
                  yValueMapper: (DailyLog? log, _) => log!.timerTime! ~/ 60,
                  dataLabelMapper: (DailyLog? log, _) => (log!.totalTime! ~/ 60).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
              StackedColumnSeries<DailyLog?, DateTime>(
                  name: 'Conduzida',
                  dataSource: listDailyLog,
                  xValueMapper: (DailyLog? log, _) => log!.day,
                  yValueMapper: (DailyLog? log, _) => log!.medTime! ~/ 60,
                  dataLabelMapper: (DailyLog? log, _) => (log!.totalTime! ~/ 60).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),

            ];


      //_seriesSessionsListD = List<ChartSeries<DailyLog, DateTime>>();
      _seriesSessionsListD = <ChartSeries<DailyLog?, DateTime>>[
              StackedColumnSeries<DailyLog?, DateTime>(
                  name: 'Timer',
                  dataSource: listDailyLog,
                  xValueMapper: (DailyLog? log, _) => log!.day,
                  yValueMapper: (DailyLog? log, _) => log!.timerSession,
                  dataLabelMapper: (DailyLog? log, _) => log!.timerSession.toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
              StackedColumnSeries<DailyLog?, DateTime>(
                  name: 'Conduzida',
                  dataSource: listDailyLog,
                  xValueMapper: (DailyLog? log, _) => log!.day,
                  yValueMapper: (DailyLog? log, _) => log!.medSession,
                  dataLabelMapper: (DailyLog? log, _) => (log!.medSession).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
            ];
    }

    ///
    /// Weeks
    ///
    /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
    int weekNumber(DateTime date) {
        var dayOfYear = int.parse(DateFormat('D').format(date));
        return ((dayOfYear - date.weekday + 10) / 7).floor();
    }

    List<MeditationLog> _getLastWeeks(List<MeditationLog> _logs) {
      var now = DateTime.now();
      var _weeks = now.subtract(const Duration(days: (7*11))); //[0..11] == 12 weeks
      var tempLogs = _logs.where((log) => log.date!.isAfter(_weeks)).toList();
      return tempLogs;
    }

    DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

    void _calculateStatisticsW(List<MeditationLog> listLogs) {

      var daySessionTemp = 0 ; 
      var monthSessionTemp = 0; 
      var yearSessionTemp = 0;
      var numDaysWithSessionW = 0;

      if (listLogs.isEmpty) {
            return;
      }

      listLogs = _getLastWeeks(listLogs);
      
      //var _endOfWeek = getDate(date.add(Duration(days: DateTime.daysPerWeek - date.weekday)));
      // List to accumulate logs in weeks -> to display graphics 
      var date = DateTime.now();
      var _startOfWeek = getDate(date.subtract(Duration(days: date.weekday - 1)));
      for (var i = 0; i < listWeeklyLog.length; i++) {
        listWeeklyLog[i] = WeeklyLog( 
              week: _startOfWeek ,
              totalTime: 0,
              timerTime: 0,
              medTime: 0,
              medSession:0,
              timerSession: 0,
              sessions: 0,
        );
        _startOfWeek = _startOfWeek.subtract(Duration(days: 7));
      }

      // temp List to accumulate logs in days to calculate sequences
      var _listDays = List.filled((7*12), DailyLog() );   
      for (var i = 0; i < _listDays.length; i++) {
        _listDays[i] = DailyLog( 
              day: DateTime.now().subtract(Duration(days: i)),
              sessions: 0,
        );
      }


      listLogs.forEach((log) {
            _totalTimeW = _totalTimeW + log.duration!;

            if (log.type == 'timer') {
               _totalTimeTimerW = _totalTimeTimerW + log.duration!;
               _numberTimerSessionsW++;
            } else {
               _totalTimeMedW = _totalTimeMedW + log.duration!;
              _numberMedSessionsW++; 
            }

            if ( log.date!.year  != yearSessionTemp  || 
                 log.date!.month != monthSessionTemp ||
                 log.date!.day != daySessionTemp) {
                    numDaysWithSessionW++;
                    daySessionTemp = log.date!.day;
                    monthSessionTemp = log.date!.month;
                    yearSessionTemp = log.date!.year;
            }  

            // insert values in the day that is in list -> search in day atribute
            var index = listWeeklyLog.indexWhere((value) => (value!.week == 
                                    getDate(log.date!.subtract(Duration(days: log.date!.weekday - 1)))));

            
            listWeeklyLog[index]!.totalTime = listWeeklyLog[index]!.totalTime! + log.duration!;
            listWeeklyLog[index]!.medTime = log.type == 'guided' ? listWeeklyLog[index]!.medTime! + log.duration! : listWeeklyLog[index]!.medTime;
            listWeeklyLog[index]!.timerTime = log.type == 'timer' ? listWeeklyLog[index]!.timerTime! + log.duration! : listWeeklyLog[index]!.timerTime;
            listWeeklyLog[index]!.medSession = log.type == 'guided' ? listWeeklyLog[index]!.medSession! + 1 : listWeeklyLog[index]!.medSession;
            listWeeklyLog[index]!.timerSession = log.type == 'timer' ? listWeeklyLog[index]!.timerSession! + 1 : listWeeklyLog[index]!.timerSession!;
            listWeeklyLog[index]!.sessions = listWeeklyLog[index]!.sessions! + 1;

            // insert values in the day that is in list -> search in day atribute
            var indexDay = _listDays.indexWhere((value) => value.day!.day == log.date!.day && 
                                               value.day!.month == log.date!.month && 
                                               value.day!.year == log.date!.year);
            _listDays[indexDay].sessions = _listDays[indexDay].sessions! + 1;



       });
       _numberSessionsW = listLogs.length;
       _averageSessionTimeW = _totalTimeW ~/ listLogs.length; 
       _dailyAverageTimeW = _totalTimeW ~/ numDaysWithSessionW;
      _dailyAverageSessionsW =_numberSessionsW / numDaysWithSessionW;

      listLogs.sort((a, b) => b.duration!.compareTo(a.duration!));
      _longestSessionW = listLogs[0].duration;

      // calculate the sequences of days with sessions
      var _numDay = 0;
      var isSequence = false;
      var daysInSequence = 0;
      var listSequences = []; 
      var isSequenceActive = false; 
      while (_numDay < _listDays.length) {
        if (_listDays[_numDay].sessions! > 0 ) {
            daysInSequence++;
            isSequence = true;
            if (_listDays[_numDay].day!.day == DateTime.now().day && 
                _listDays[_numDay].day!.month == DateTime.now().month && 
                _listDays[_numDay].day!.year == DateTime.now().year )  {
                 isSequenceActive = true;
            };
        } else {
          if (isSequence) { 
            listSequences.add(daysInSequence);
          }
          daysInSequence = 0;
          isSequence = false;
        }
        _numDay++;
      }

      if (isSequenceActive) {
        _actualSequenceOfDaysWithSessionW = listSequences[0] ?? 1;
      } else {
        _actualSequenceOfDaysWithSessionW = 0;
      }

       listSequences.sort((a,b) => b.compareTo(a));
      _greaterSequenceOfDaysWithSessionW = listSequences[0];

      var listTemp = List.from(_listDays);
      listTemp.sort((a,b) => b.sessions.compareTo(a.sessions));
      _greaterNumDailySessionsW = listTemp[0].sessions;

      // reorganize for graphics in UI
      listWeeklyLog.sort((a,b) => a!.week!.compareTo(b!.week!));

      //_seriesTimeListM = List<ChartSeries<MonthlyLog, String>>();
      _seriesTimeListW = <ChartSeries<WeeklyLog?, String>>[
              StackedColumnSeries<WeeklyLog?, String>(
                  name: 'Timer',
                  dataSource: listWeeklyLog,
                  xValueMapper: (WeeklyLog? log, _) => log!.week!.day.toString()+'/'+log.week!.month.toString() ,
                  yValueMapper: (WeeklyLog? log, _) => log!.timerTime! ~/ 60,
                  dataLabelMapper: (WeeklyLog? log, _) => (log!.timerTime! ~/ 60).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
              StackedColumnSeries<WeeklyLog?, String>(
                  name: 'Conduzida',
                  dataSource: listWeeklyLog,
                  xValueMapper: (WeeklyLog? log, _) => log!.week!.day.toString()+'/'+log.week!.month.toString() ,
                  yValueMapper: (WeeklyLog? log, _) => log!.medTime! ~/ 60,
                  dataLabelMapper: (WeeklyLog? log, _) => (log!.medTime! ~/ 60).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),         
            ];


      //_seriesSessionsListM = List<ChartSeries<MonthlyLog, String>>();
      _seriesSessionsListW = <ChartSeries<WeeklyLog?, String>>[
              StackedColumnSeries<WeeklyLog?, String>(
                  name: 'Timer',
                  dataSource: listWeeklyLog,
                  xValueMapper: (WeeklyLog? log, _) => log!.week!.day.toString()+'/'+log.week!.month.toString() ,
                  yValueMapper: (WeeklyLog? log, _) => log!.timerSession,
                  dataLabelMapper: (WeeklyLog? log, _) => (log!.timerSession).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
              StackedColumnSeries<WeeklyLog?, String>(
                  name: 'Conduzida',
                  dataSource: listWeeklyLog,
                  xValueMapper: (WeeklyLog? log, _) => log!.week!.day.toString()+'/'+log.week!.month.toString() ,
                  yValueMapper: (WeeklyLog? log, _) => log!.medSession,
                  dataLabelMapper: (WeeklyLog? log, _) => (log!.medSession).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
            ];
    }

    /// 
    /// Months
    /// 
    List<MeditationLog> _getLastMonths(List<MeditationLog> _logs) {
      var now = DateTime.now();
      var _Months = now.subtract(const Duration(days: 365-1));  //[0..364] = 12 meses
      var tempLogs = _logs.where((log) => log.date!.isAfter(_Months)).toList();
      return tempLogs;
    }

    String addZeros( int num) {
      if (num < 10) { 
        return '0' + num.toString();
      } else { 
        return num.toString();
        }
    }

    void _calculateStatisticsM(List<MeditationLog> listLogs) {

      var daySessionTemp = 0 ; 
      var monthSessionTemp = 0; 
      var yearSessionTemp = 0;
      var numDaysWithSessionM = 0;

      if (listLogs.isEmpty) {
            return;
      }

      listLogs = _getLastMonths(listLogs);

      // List to accumulate logs in months -> to display graphics 
      var _month = DateTime.now().month;
      var _year = DateTime.now().year;
      for (var i = 0; i < listMonthlyLog.length; i++) {
        listMonthlyLog[i] = MonthlyLog( 
              month: _year.toString() + addZeros(_month),
              totalTime: 0,
              timerTime: 0,
              medTime: 0,
              medSession:0,
              timerSession: 0,
              sessions: 0,
        );
        if ( _month  == 1) {
          _month = 12;
          _year--;
        } else { 
          _month--;
        }
      }

      // temp List to accumulate logs in days to calculate sequences
      var _listDays = List.filled(365, DailyLog());   
      for (var i = 0; i < _listDays.length; i++) {
        _listDays[i] = DailyLog( 
              day: DateTime.now().subtract(Duration(days: i)),
              sessions: 0,
        );
      }


      listLogs.forEach((log) {
            _totalTimeM = _totalTimeM + log.duration!;

            if (log.type == 'timer') {
               _totalTimeTimerM = _totalTimeTimerM + log.duration!;
               _numberTimerSessionsM++;
            } else {
               _totalTimeMedM = _totalTimeMedM + log.duration!;
              _numberMedSessionsM++; 
            }

            if ( log.date!.year  != yearSessionTemp  || 
                 log.date!.month != monthSessionTemp ||
                 log.date!.day != daySessionTemp) {
                    numDaysWithSessionM++;
                    daySessionTemp = log.date!.day;
                    monthSessionTemp = log.date!.month;
                    yearSessionTemp = log.date!.year;
            }  

            // insert values in the day that is in list -> search in day atribute
            var index = listMonthlyLog.indexWhere((value) => (value!.month == 
                                    log.date!.year.toString() + addZeros(log.date!.month) ));

            
            listMonthlyLog[index]!.totalTime = listMonthlyLog[index]!.totalTime! + log.duration!;
            listMonthlyLog[index]!.medTime = log.type == 'guided' ? listMonthlyLog[index]!.medTime! + log.duration! : listMonthlyLog[index]!.medTime;
            listMonthlyLog[index]!.timerTime = log.type == 'timer' ? listMonthlyLog[index]!.timerTime! + log.duration! : listMonthlyLog[index]!.timerTime;
            listMonthlyLog[index]!.medSession = log.type == 'guided' ? listMonthlyLog[index]!.medSession! + 1 : listMonthlyLog[index]!.medSession;
            listMonthlyLog[index]!.timerSession = log.type == 'timer' ? listMonthlyLog[index]!.timerSession! + 1 : listMonthlyLog[index]!.timerSession!;
            listMonthlyLog[index]!.sessions = listMonthlyLog[index]!.sessions! + 1;
            
            // insert values in the day that is in list -> search in day atribute
            var indexDay = _listDays.indexWhere((value) => value.day!.day == log.date!.day && 
                                               value.day!.month == log.date!.month && 
                                               value.day!.year == log.date!.year);
            _listDays[indexDay].sessions = _listDays[indexDay].sessions! + 1;



       });
       _numberSessionsM = listLogs.length;
       _averageSessionTimeM = _totalTimeM ~/ listLogs.length; 
       _dailyAverageTimeM = _totalTimeM ~/ numDaysWithSessionM;
      _dailyAverageSessionsM =_numberSessionsM / numDaysWithSessionM;

      listLogs.sort((a, b) => b.duration!.compareTo(a.duration!));
      _longestSessionM = listLogs[0].duration;

      // calculate the sequences of days with sessions
      var _numDay = 0;
      var isSequence = false;
      var daysInSequence = 0;
      var listSequences = []; 
      var isSequenceActive = false; 
      while (_numDay < _listDays.length) {
        if (_listDays[_numDay].sessions! > 0 ) {
            daysInSequence++;
            isSequence = true;
            if (_listDays[_numDay].day!.day == DateTime.now().day && 
                _listDays[_numDay].day!.month == DateTime.now().month && 
                _listDays[_numDay].day!.year == DateTime.now().year )  {
                 isSequenceActive = true;
            };
        } else {
          if (isSequence) { 
            listSequences.add(daysInSequence);
          }
          daysInSequence = 0;
          isSequence = false;
        }
        _numDay++;
      }

      if (isSequenceActive) {
        _actualSequenceOfDaysWithSessionM = listSequences[0] ?? 1;
      } else {
        _actualSequenceOfDaysWithSessionM = 0;
      }

       listSequences.sort((a,b) => b.compareTo(a));
      _greaterSequenceOfDaysWithSessionM = listSequences[0];

      var listTemp = List.from(_listDays);
      listTemp.sort((a,b) => b.sessions.compareTo(a.sessions));
      _greaterNumDailySessionsM = listTemp[0].sessions;

      // reorganize for graphics in UI
      listMonthlyLog.sort((a,b) => a!.month!.compareTo(b!.month!));

      //_seriesTimeListM = List<ChartSeries<MonthlyLog, String>>();
      _seriesTimeListM = <ChartSeries<MonthlyLog?, String>>[
              StackedColumnSeries<MonthlyLog?, String>(
                  name: 'Timer',
                  dataSource: listMonthlyLog,
                  xValueMapper: (MonthlyLog? log, _) => log!.month!.substring(4),
                  yValueMapper: (MonthlyLog? log, _) => log!.timerTime! ~/ 60,
                  dataLabelMapper: (MonthlyLog? log, _) => (log!.timerTime! ~/ 60).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
              StackedColumnSeries<MonthlyLog?, String>(
                  name: 'Conduzida',
                  dataSource: listMonthlyLog,
                  xValueMapper: (MonthlyLog? log, _) => log!.month!.substring(4),
                  yValueMapper: (MonthlyLog? log, _) => log!.medTime! ~/ 60,
                  dataLabelMapper: (MonthlyLog? log, _) => (log!.medTime! ~/ 60).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),         
            ];


      //_seriesSessionsListM = List<ChartSeries<MonthlyLog, String>>();
      _seriesSessionsListM = <ChartSeries<MonthlyLog?, String>>[
              StackedColumnSeries<MonthlyLog?, String>(
                  name: 'Timer',
                  dataSource: listMonthlyLog,
                  xValueMapper: (MonthlyLog? log, _) => log!.month!.substring(4),
                  yValueMapper: (MonthlyLog? log, _) => log!.timerSession,
                  dataLabelMapper: (MonthlyLog? log, _) => (log!.timerSession).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
              StackedColumnSeries<MonthlyLog?, String>(
                  name: 'Conduzida',
                  dataSource: listMonthlyLog,
                  xValueMapper: (MonthlyLog? log, _) => log!.month!.substring(4),
                  yValueMapper: (MonthlyLog? log, _) => log!.medSession,
                  dataLabelMapper: (MonthlyLog? log, _) => (log!.medSession).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),

            ];
    }

    ///
    /// Years
    ///
    List<MeditationLog> _getLastYears(List<MeditationLog> _logs) {
      var now = DateTime.now();
      var _Months = now.subtract(Duration(days: 365*numYears));
      var tempLogs = _logs.where((log) => log.date!.isAfter(_Months)).toList();
      return tempLogs;
    }

    void _calculateStatisticsY(List<MeditationLog> listLogs) {

      var daySessionTemp = 0 ; 
      var monthSessionTemp = 0; 
      var yearSessionTemp = 0;
      var numDaysWithSessionY = 0;

      if (listLogs.isEmpty) {
            return;
      }

      listLogs = _getLastYears(listLogs);

      // List to accumulate logs in years -> to display graphics 
      var listYearlyLog = List.filled(numYears, YearlyLog());
      var _year = DateTime.now().year;
      for (var i = 0; i < listYearlyLog.length; i++) {
        listYearlyLog[i] = YearlyLog( 
              year: _year--,
              totalTime: 0,
              timerTime: 0,
              medTime: 0,
              medSession:0,
              timerSession: 0,
              sessions: 0,
        );
      }

      // temp List to accumulate logs in days to calculate sequences
      var _listDays = List.filled(365*numYears, DailyLog());   
      for (var i = 0; i < _listDays.length; i++) {
        _listDays[i] = DailyLog( 
              day: DateTime.now().subtract(Duration(days: i)),
              sessions: 0,
        );
      }


      listLogs.forEach((log) {
            _totalTimeY = _totalTimeY + log.duration!;

            if (log.type == 'timer') {
               _totalTimeTimerY = _totalTimeTimerY + log.duration!;
               _numberTimerSessionsY++;
            } else {
               _totalTimeMedY = _totalTimeMedY + log.duration!;
              _numberMedSessionsY++; 
            }

            if ( log.date!.year  != yearSessionTemp  || 
                 log.date!.month != monthSessionTemp ||
                 log.date!.day != daySessionTemp) {
                    numDaysWithSessionY++;
                    daySessionTemp = log.date!.day;
                    monthSessionTemp = log.date!.month;
                    yearSessionTemp = log.date!.year;
            }  

            // insert values in the day that is in list -> search in day atribute
            var index = listYearlyLog.indexWhere((value) => (value.year == log.date!.year ));

            listYearlyLog[index].totalTime = listYearlyLog[index].totalTime! + log.duration!;
            listYearlyLog[index].medTime = log.type == 'guided' ? listYearlyLog[index].medTime! + log.duration! : listYearlyLog[index].medTime;
            listYearlyLog[index].timerTime = log.type == 'timer' ? listYearlyLog[index].timerTime! + log.duration! : listYearlyLog[index].timerTime;
            listYearlyLog[index].medSession = log.type == 'guided' ? listYearlyLog[index].medSession! + 1 : listYearlyLog[index].medSession;
            listYearlyLog[index].timerSession = log.type == 'timer' ? listYearlyLog[index].timerSession! + 1 : listYearlyLog[index].timerSession!;
            listYearlyLog[index].sessions = listYearlyLog[index].sessions! + 1;
            
            // insert values in the day that is in list -> search in day atribute
            var indexDay = _listDays.indexWhere((value) => value.day!.day == log.date!.day && 
                                               value.day!.month == log.date!.month && 
                                               value.day!.year == log.date!.year);
            _listDays[indexDay].sessions =  _listDays[indexDay].sessions! + 1;
       });
       _numberSessionsY = listLogs.length;
       _averageSessionTimeY = _totalTimeY ~/ listLogs.length; 
       _dailyAverageTimeY = _totalTimeY ~/ numDaysWithSessionY;
      _dailyAverageSessionsY =_numberSessionsY / numDaysWithSessionY;

      listLogs.sort((a, b) => b.duration!.compareTo(a.duration!));
      _longestSessionY = listLogs[0].duration;

      // calculate the sequences of days with sessions
      var _numDay = 0;
      var isSequence = false;
      var daysInSequence = 0;
      var listSequences = []; 
      var isSequenceActive = false; 
      while (_numDay < _listDays.length) {
        if (_listDays[_numDay].sessions! > 0 ) {
            daysInSequence++;
            isSequence = true;
            if (_listDays[_numDay].day!.day == DateTime.now().day && 
                _listDays[_numDay].day!.month == DateTime.now().month && 
                _listDays[_numDay].day!.year == DateTime.now().year )  {
                 isSequenceActive = true;
            };
        } else {
          if (isSequence) { 
            listSequences.add(daysInSequence);
          }
          daysInSequence = 0;
          isSequence = false;
        }
        _numDay++;
      }

      if (isSequenceActive) {
        _actualSequenceOfDaysWithSessionY = listSequences[0] ?? 1;
      } else {
        _actualSequenceOfDaysWithSessionY = 0;
      }

       listSequences.sort((a,b) => b.compareTo(a));
      _greaterSequenceOfDaysWithSessionY = listSequences[0];

      var listTemp = List.from(_listDays);
      listTemp.sort((a,b) => b.sessions.compareTo(a.sessions));
      _greaterNumDailySessionsY = listTemp[0].sessions;

      // reorganize for graphics in UI
      listYearlyLog.sort((a,b) => a.year!.compareTo(b.year!));

      _seriesTimeListY = <ChartSeries<YearlyLog?, String>>[
              StackedColumnSeries<YearlyLog?, String>(
                  name: 'Timer',
                  dataSource: listYearlyLog,
                  xValueMapper: (YearlyLog? log, _) => log!.year.toString(),
                  yValueMapper: (YearlyLog? log, _) => log!.timerTime! ~/3600,
                  dataLabelMapper: (YearlyLog? log, _) => (log!.timerTime! ~/ 3600).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
              StackedColumnSeries<YearlyLog?, String>(
                  name: 'Conduzida',
                  dataSource: listYearlyLog,
                  xValueMapper: (YearlyLog? log, _) => log!.year.toString(),
                  yValueMapper: (YearlyLog? log, _) => log!.medTime! ~/ 3600,
                  dataLabelMapper: (YearlyLog? log, _) => (log!.medTime! ~/ 3600).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),         
            ];


      //_seriesSessionsListM = List<ChartSeries<MonthlyLog, String>>();
      _seriesSessionsListY = <ChartSeries<YearlyLog?, String>>[
              StackedColumnSeries<YearlyLog?, String>(
                  name: 'Timer',
                  dataSource: listYearlyLog,
                  xValueMapper: (YearlyLog? log, _) => log!.year.toString(),
                  yValueMapper: (YearlyLog? log, _) => log!.timerSession,
                  dataLabelMapper: (YearlyLog? log, _) => (log!.timerSession).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
              StackedColumnSeries<YearlyLog?, String>(
                  name: 'Conduzida',
                  dataSource: listYearlyLog,
                  xValueMapper: (YearlyLog? log, _) => log!.year.toString(),
                  yValueMapper: (YearlyLog? log, _) => log!.medSession,
                  dataLabelMapper: (YearlyLog? log, _) => (log!.medSession).toString(),
                  dataLabelSettings: DataLabelSettings(
                        isVisible: false, 
                        showZeroValue: false,
                        labelAlignment: ChartDataLabelAlignment.top, 
                        color: Colors.grey[400],
                        textStyle: TextStyle(fontSize: 10),
                        showCumulativeValues: true),
              ),
            ];
    }

    String _roundTime( int _time) {
      var _duration = Duration(seconds: _time);

      var hour = _duration.inHours;
      num remainderMinutes = _duration.inMinutes.remainder(60);
      num remainderSeconds = _duration.inSeconds.remainder(60);

      var strHour = hour > 0 ? '${hour}h ' : '';
      var strMinutes = remainderMinutes > 0 ? '${remainderMinutes}min ' : '';
      var strSeconds = remainderSeconds > 0 ? '${remainderSeconds}s ' : '0s';
      return strHour + strMinutes + strSeconds;
   }
  
}