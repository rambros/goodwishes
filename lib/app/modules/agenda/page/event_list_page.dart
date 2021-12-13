import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/agenda/controller/event_list_controller.dart';
import '/app/modules/agenda/model/event_data_souce.dart';
import '/app/modules/agenda/model/event_model.dart';
import 'package:intl/intl.dart';
import '/app/shared/utils/ui_utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({Key? key}) : super(key: key);

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends ModularState<EventListPage, EventListController> {
  Future<List<EventModel>?>? listEvents;

  @override
  void initState() {
    super.initState();
    controller.init();
    listEvents = controller.getEventListByID('258');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Atividades'),
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
                    verticalSpace(16),
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
                    future: listEvents,
                    builder: (BuildContext context, AsyncSnapshot<List<EventModel>?> snapshot) {
                      //print(snapshot.hasData);
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
                        // return ListView.builder(
                        //   itemCount: snapshot.data.length,
                        //   itemBuilder: (_, index) {
                        //     var item = snapshot.data[index];
                        //     return ListTile(
                        //       contentPadding: EdgeInsets.all(4),
                        //       title: Text(formatDate(item.startTimestamp) + ' - ' + item.name),
                        //       //subtitle:  Text(formatDate(item.startTimestamp)),
                        //       onTap: () {
                        //         Modular.to.pushNamed('/agenda/event/details', arguments: item);
                        //       }
                        //     );
                        //   },
                        // );
                        return SfCalendar(
                            firstDayOfWeek: 1,
                            showNavigationArrow: true,
                            view: CalendarView.schedule,
                            dataSource: EventDataSource(snapshot.data),
                            appointmentTimeTextFormat: 'Hm',
                            scheduleViewSettings: ScheduleViewSettings(
                                  hideEmptyScheduleWeek: true,
                                  appointmentTextStyle: TextStyle(
                                      fontSize: 14, 
                                      fontWeight: FontWeight.w400, color: Colors.black54,
                                      ),
                                  monthHeaderSettings: MonthHeaderSettings(
                                      monthFormat: 'MMMM yyyy',
                                      height: 90,
                                      textAlign: TextAlign.left,
                                      backgroundColor: Theme.of(context).accentColor,
                                      monthTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400)),
                            ),
                            onTap: _showDetails,
                            onLongPress: _showItemDetails,
                        );
                      }
                    },
                  ),
                )
              ])),
    );
  }

  void _showDetails( CalendarTapDetails details) {
    if ((details.targetElement == CalendarElement.appointment ||
      details.targetElement == CalendarElement.viewHeader)) {
            var event = details.appointments![0] as EventModel?;
            Modular.to.pushNamed('/agenda/event/details', arguments: event);
      }
  }

  void _showItemDetails( CalendarLongPressDetails details) {
    var event = details.appointments![0] as EventModel?;
    Modular.to.pushNamed('/agenda/event/details', arguments: event);
  }


  String formatDate( String date) {
    var dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    var _date = dateFormat.parse(date);
    return '${_date.day}/${_date.month}/${_date.year}'; 
  }

}


