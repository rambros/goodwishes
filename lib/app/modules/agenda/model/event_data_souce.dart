import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'event_model.dart';

class EventDataSource extends CalendarDataSource {
  
  EventDataSource(List<EventModel>? source){
     appointments = source;
  }

  var dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  @override
  DateTime getStartTime(int index) {
    var _startTime = dateFormat.parse(appointments![index].startTimestamp);
    return _startTime;
  }

  @override
  DateTime getEndTime(int index) {
    var _endTime = dateFormat.parse(appointments![index].endTimestamp);
    return _endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].name;
  }

  @override
  Color getColor(int index) {
    switch (appointments![index].eventTypeId) {
      case 6: // workshop
          return Colors.orange[400]!;
          break;
      case 1: //palestra
          return Colors.blue[200]!;
          break;
      case 5: //retiro
          return Colors.red[200]!;
          break;
      default:
          return Colors.green[200]!;
    }
  }




}