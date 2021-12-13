import 'dart:convert';

import 'package:dio/dio.dart';
import '/app/modules/agenda/model/event_model.dart';

class EventListController  {
  
final String _baseUrl = 'http://events.brahmakumaris.org/bkregistration'; 
//'http://events.brahmakumaris.org/bkregistration/organisationEventReportController.do?orgEventTemplate=jsonEventExport.ftl&orgId=2&fromIndex=0&toIndex=10&mimeType=text/plain';
  late Dio _dio;
  var result = '';
  bool? busy;


void init() {
      var options = BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: 5000,
    );

    _dio = Dio(options);
}

Future<List<EventModel>?> getEventListByID(String ID) async {
  var parm = '/organisationEventReportController.do?orgEventTemplate=jsonEventExport.ftl&orgId=$ID&fromIndex=0&toIndex=100&mimeType=text/plain';
  var response = await _dio.get(parm);
  var result = json.decode(response.data);
  var list = result['response']['data'].map<EventModel>((c) => EventModel.fromJson(c)).toList()
          as List<EventModel>?;
  return list;
  }



}