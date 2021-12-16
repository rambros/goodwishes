import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '/app/shared/utils/color.dart';
import 'reminder.dart';
import 'time_zone.dart';
// import 'package:journey/screens/reminder/reminder-stats.dart';

Time? timeofalarm;
var showtime;
List<String>? multipleAlarm = [];
Color mainColor = Color(0xFFf45905);

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class _AlarmState extends State<Alarm> {
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    initializeNotificationPlugin();
    getalarmtime();
  }

  void initializeNotificationPlugin() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings(
        //'@mipmap/logo_meditabk',
        'logo_branco');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //   Future onDidReceiveLocalNotification(
  //     int id, String title, String body, String payload) async {
  //   // display a dialog with the notification details, tap ok to go to another page
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //           title: Text(title),
  //           content: Text(body),
  //           actions: [
  //             CupertinoDialogAction(
  //               isDefaultAction: true,
  //               child: Text('Ok'),
  //               onPressed: () async {
  //                 Navigator.of(context, rootNavigator: true).pop();
  //                 await Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => SecondScreen(payload),
  //                   ),
  //                 );
  //               },
  //             )
  //           ],
  //         ),
  //   );
  // }

  void getalarmtime() async {
    var myPrefs = await SharedPreferences.getInstance();

    setState(() {
      if (myPrefs.getStringList('multipleAlarm') != null) {
        multipleAlarm = myPrefs.getStringList('multipleAlarm');
      }
    });
  }

  void selecttime(BuildContext context) async {
    var selectedTimeRTL = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTimeRTL != null) {
      var hour = selectedTimeRTL.hour;
      var min = selectedTimeRTL.minute;
      //print(selectedTimeRTL.hashCode);
      //print("============>$hour");
      //print("============>$min ");
      timeofalarm = Time(hour, min, 0);
      setState(() {
        showtime = TimeOfDay(hour: hour, minute: min).format(context);
      });
      var myPrefs = await SharedPreferences.getInstance();

      if (!multipleAlarm!
          .any((alarm) => alarm.contains('${selectedTimeRTL.hashCode}'))) {
        var data =
            jsonEncode({'id': selectedTimeRTL.hashCode, 'time': showtime});

        multipleAlarm!.add(data);
        await myPrefs.setStringList('multipleAlarm', multipleAlarm!);
        // myPrefs.setString('alarm_time', '$showtime');

        if (timeofalarm != null) {
          scheduledalarm(selectedTimeRTL.hashCode, timeofalarm);
          snackbar(context, 'Lembrete diário definido para $showtime.');
        }
      } else {
        snackbar(context, 'Lembrete diário já existe para $showtime');
      }
    }
  }

  void snackbar(BuildContext myContext, String text) {
    final snackBar = SnackBar(
      content: Text('$text '),
      duration: Duration(seconds: 2),
    );
    Scaffold.of(myContext).showSnackBar(snackBar);
  }

  Future _scheduledDateTime(var timeofalarm) async {
    final timeZone = TimeZone();
    final deviceTimeZoneName = await timeZone.getTimeZoneName();
    final currentLocation = await timeZone.getLocation(deviceTimeZoneName);
    final tzDateTimeNow = tz.TZDateTime.now(currentLocation);
    var scheduledNotificationDateTime = tz.TZDateTime(
        currentLocation,
        tzDateTimeNow.year,
        tzDateTimeNow.month,
        tzDateTimeNow.day,
        timeofalarm.hour,
        timeofalarm.minute);
    if (scheduledNotificationDateTime.isBefore(tzDateTimeNow)) {
      scheduledNotificationDateTime =
          scheduledNotificationDateTime.add(const Duration(days: 1));
    }
    return scheduledNotificationDateTime;
  }

  void scheduledalarm(int id, var timeofalarm) async {
    final scheduledNotificationDateTime = await _scheduledDateTime(timeofalarm);
    //final scheduledDateTime = Time(timeofalarm.hour, timeofalarm.minute);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 
        'your  channel name', 
        channelDescription: 'your  channel description',
        //sound: 'sd',
        autoCancel: true,
        playSound: true,
        color: primaryColor,
        importance: Importance.max,
        priority: Priority.high);

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'sd.aiff', presentSound: true);

    final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        //for multiple alarm give unique id each time as--> DateTime.now().millisecond,
        id,
        'Hora de meditar',
        '$showtime',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time
        // scheduledNotificationRepeatFrequency:
        //         ScheduledNotificationRepeatFrequency.daily,
        );
    //print("alarm set");
  }

  void showNotification() async {
    var android = AndroidNotificationDetails(
        'channel id', 
        'channel NAME', 
        channelDescription: 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Nova Notificação', 'Flutter Local Notification', platform,
        payload: 'seu lembrete ');
  }

  @override
  Widget build(BuildContext bContext) {
    return SafeArea(
        bottom: true,
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AppBar(
                  //backgroundColor: Colors.transparent,
                  titleSpacing: 12.0,
                  //automaticallyImplyLeading: false,
                  title: const Text('Lembretes para Meditar'),
                  // title: RichText(
                  //   text: TextSpan(children: [
                  //     TextSpan(text: "\n"),
                  //     TextSpan(
                  //       text: "Defina lembretes",
                  //       style: TextStyle(
                  //           color: Color(0xFF1A1A1A),
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.w700),
                  //     ),
                  //     TextSpan(text: "\n"),
                  //     TextSpan(
                  //       text:
                  //           "Para manter-se paz e centrado, dê uma paradinha algumas vezes ao dia",
                  //       style:
                  //           TextStyle(color: Color(0xFF1A1A1A), fontSize: 12),
                  //     )
                  //   ]),
                  // ),
                  elevation: 0.0),
              SizedBox(
                height: 20,
              ),
              Reminder(),
              SizedBox(
                height: MediaQuery.of(bContext).size.height * .03,
              ),
              multipleAlarm != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: multipleAlarm!.length,
                      itemBuilder: (bContext, index) {
                        var alarm = jsonDecode(multipleAlarm![index]);

                        return Dismissible(
                          secondaryBackground: Container(
                              padding: EdgeInsets.only(right: 20),
                              color: Theme.of(context).colorScheme.secondary,
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              )),
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            var myPrefs = await SharedPreferences.getInstance();
                            await flutterLocalNotificationsPlugin
                                .cancel(jsonDecode(multipleAlarm![index])['id']);
                            multipleAlarm!.removeAt(index);
                            await myPrefs.setStringList(
                                'multipleAlarm', multipleAlarm!);

                            setState(() {
                              multipleAlarm =
                                  myPrefs.getStringList('multipleAlarm');
                            });

                            snackbar(bContext,
                                "Lembrete para ${alarm['time']} foi removido !");
                          },
                          background: Container(color: primaryColor),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                "${alarm['time']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700),
                              ),
                              trailing: IconButton(
                                color: Theme.of(context).colorScheme.secondary,
                                icon: Icon(
                                  Icons.delete,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  var myPrefs =
                                      await SharedPreferences.getInstance();
                                  await flutterLocalNotificationsPlugin.cancel(
                                      jsonDecode(multipleAlarm![index])['id']);
                                  multipleAlarm!.removeAt(index);
                                  await myPrefs.setStringList('multipleAlarm', multipleAlarm!);

                                  setState(() {
                                    multipleAlarm =
                                        myPrefs.getStringList('multipleAlarm');
                                  });

                                  snackbar(bContext,
                                      "Lembrete para ${alarm['time']} foi removido !");
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox(),
              Builder(builder: (context) {
                return Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton.extended(
                    heroTag: UniqueKey,
                    label: Icon(
                      Icons.add,
                      color: Color(0xff2d386b),
                      size: 20,
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () => selecttime(context),
                  ),
                );
              }),
              SizedBox(
                height: 70,
              )
            ],
          ),
        )));
  }
}
