import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/agenda/controller/event_registration_controller.dart';
import '/app/modules/agenda/model/event_model.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventRegistrationPage extends StatefulWidget {
  const EventRegistrationPage({Key? key}) : super(key: key);

  @override
  _EventRegistrationPageState createState() => _EventRegistrationPageState();
}

class _EventRegistrationPageState extends ModularState<EventRegistrationPage, EventRegistrationController> {
  Future<String?>? _formSubscription;

  @override
  void initState() {
    super.initState();
    //controller.init();
    _formSubscription = controller.getForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Eventos'),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //verticalSpace(16),
                    // MaterialButton(
                    //   color: Theme.of(context).accentColor,
                    //   child: Text('Obter Lista de Eventos'),
                    //   onPressed: () {
                    //     controller.getEventListByID('258');
                    //   },
                    // ),
                    // MaterialButton(
                    //   color: Colors.orange,
                    //   child: Text('Enviar!'),
                    //   onPressed: () {
                    //     controller.submitUser();
                    //   },
                    // ),
                  ],
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _formSubscription,
                    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              Text('Error: ${snapshot.error}'),
                            ],
                          ),
                        );
                      } else {
                        return Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Container(
                                    //padding: EdgeInsets.all(8),
                                    // child: EasyWebView(
                                    //   src: snapshot.data,
                                    //   isHtml: true, // Use Html syntax
                                    //   isMarkdown: false,
                                    //   onLoaded: () {}, // Use markdown syntax
                                    //   //convertToWidegts: false, // Try to convert to flutter widgets
                                    //   width: MediaQuery.of(context).size.width * 1.0,
                                    //   //height: MediaQuery.of(context).size.height * 1.80,
                                    // ),
                                  ),
                                ),
                                ],
                            );
                      }
                    },
                  ),
                )
              ])),
    );
  }

  // void _showDetails( CalendarTapDetails details) {
  //   var event = details.appointments[0] as EventModel;
  //   Modular.to.pushNamed('/agenda/event/details', arguments: event);
  // }


  String formatDate( String date) {
    var dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    var _date = dateFormat.parse(date);
    return '${_date.day}/${_date.month}/${_date.year}'; 
  }

}

class EventDataSource extends CalendarDataSource {
  
  EventDataSource(List<EventModel> source){
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

  //  @override
  // Color getColor(int index) {
  //   //return appointments[index].background;
  //   //return Colors.Theme.of(context).accentColor;
  // }




}
