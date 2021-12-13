import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/agenda/controller/event_list_controller.dart';
import '/app/modules/agenda/model/event_data_souce.dart';
import '/app/modules/agenda/model/event_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AgendaListPage extends StatefulWidget {
  const AgendaListPage({Key? key}) : super(key: key);

  @override
  _AgendaListPageState createState() => _AgendaListPageState();
}

class _AgendaListPageState extends ModularState<AgendaListPage, EventListController> {
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
        title: Text('Agenda de atividades'),
      ),
      //backgroundColor: Colors.white,  //Theme.of(context).accentColor,
      body: FutureBuilder(
              future: listEvents,
              builder: (BuildContext context, AsyncSnapshot<List<EventModel>?> snapshot) {
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
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: SfCalendar(
                        firstDayOfWeek: 1,
                        showNavigationArrow: true,
                        appointmentTimeTextFormat: 'Hm',
                        view: CalendarView.month,
                        dataSource: EventDataSource(snapshot.data),
                        monthViewSettings: MonthViewSettings(
                          //navigationDirection: MonthNavigationDirection.horizontal,
                          //appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                          showAgenda: true,
                          agendaStyle: AgendaStyle(
                                //backgroundColor: Color(0xFF066cccc),
                                appointmentTextStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400, 
                                    color: Colors.black54,),
                                dateTextStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).accentColor,),
                                dayTextStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).accentColor,),
                              ),
                          //agendaViewHeight: 200,
                          dayFormat: 'EEE',
                        ),
                        onTap: _showDetails,
                      ),
                  );
                }
              },
            ),
      
    );
  }


  void _showDetails( CalendarTapDetails details) {

    if ((details.targetElement == CalendarElement.appointment ||
      details.targetElement == CalendarElement.agenda)) {
            var event = details.appointments![0] as EventModel?;
            Modular.to.pushNamed('/agenda/event/details', arguments: event);
      }
  }

}

