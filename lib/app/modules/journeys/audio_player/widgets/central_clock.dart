import 'dart:core';

import 'package:flutter/material.dart';
//import 'package:flutter_circular_chart_two/flutter_circular_chart_two.dart';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';

import '/app/shared/services/service_locator.dart';
import '../notifiers/notifiers.dart';
import '../audio_player_controller.dart';

class CentralClock extends StatelessWidget {
  CentralClock({Key? key}) : super(key: key);

  final _chartSize = const Size(300.0, 300.0);
  final _chartKey = GlobalKey<AnimatedCircularChartState>();
  String elapsedTime = '00:00';
  late Duration total;

  @override
  Widget build(BuildContext context) {
    final audioPlayerController = getIt<AudioPlayerController>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: audioPlayerController.progressNotifier,
      builder: (_, value, __) {
        total = value.total;
        var timeRemaining = value.total - value.current;
        elapsedTime = (timeRemaining == Duration.zero || timeRemaining == null) 
            ? updateTime(Duration.zero)
            : updateTime(timeRemaining);

        return AnimatedCentralClock(
          chartKey: _chartKey,
          chartSize: _chartSize,
          label: '$elapsedTime',
        );
      },
    );
  }

  List<CircularStackEntry> _generateChartData(int minute, int second) {
    /// Check the graph position
    var segmentValue = (total.inMilliseconds / 1000).round() - second.toDouble();
    segmentValue = segmentValue == 0 ? 0.01 : segmentValue; 
    //print ('total ${total.inMilliseconds} - valor $segmentValue   segundos $second');
    var data = <CircularStackEntry>[
      CircularStackEntry([
        CircularSegmentEntry(
          second.toDouble(),
          Colors.blue,
          rankKey: 'completado',
        ),
        CircularSegmentEntry(
          segmentValue,
          Colors.white,
          rankKey: 'restando',
        )
      ])
    ];

    return data;
  }

  ///Update time of circular progress bar
  String updateTime(Duration timer) {
      var milliseconds = timer.inMilliseconds;
      var hundreds = (milliseconds / 10).truncate();
      var seconds = (hundreds / 100).truncate();
      var minutes = (seconds / 60).truncate();

      var data = _generateChartData(minutes, seconds);
      _chartKey.currentState?.updateData(data);
      elapsedTime =
          '${(minutes % 60).toString().padLeft(2, '0')} : ${(seconds % 60).toString().padLeft(2, '0')}';
      return elapsedTime;
  }
}

class AnimatedCentralClock extends StatelessWidget {
  const AnimatedCentralClock({
    Key? key,
    required GlobalKey<AnimatedCircularChartState> chartKey,
    required Size chartSize,
    required String label,
  })  : _chartKey = chartKey,
        _chartSize = chartSize,
        _label = label,
        super(key: key);

  final GlobalKey<AnimatedCircularChartState> _chartKey;
  final Size _chartSize;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return AnimatedCircularChart(
      key: _chartKey,
      size: _chartSize,
      initialChartData:
          // todo: Refactor.
          //_generateChartData(0,0),
          <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(
              00.00,
              Colors.blue,
              rankKey: 'completado',
            ),
            CircularSegmentEntry(
              100.00,
              Colors.white,
              rankKey: 'restando',
            ),
          ],
          rankKey: 'progresso',
        ),
      ],
      chartType: CircularChartType.Radial,
      percentageValues: false,
      holeLabel: _label,
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 44.0,
      ),
    );
  }
}

