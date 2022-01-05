import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_controller.dart';
import 'clock/clock.dart';

class Reminder extends StatelessWidget {
  final _appSettings = Modular.get<AppController>();
  @override
  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Clock(),
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Para manter-se em paz e centrado, \ndê uma paradinha algumas vezes ao dia',
                  //"Meditate",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  //"06:12 PM",
                  'Hora de Meditar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _appSettings.isDarkTheme! 
                      ? Theme.of(context).colorScheme.secondary
                      : Color(0xff2d386b),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Text(
            //       "Time Left",
            //       style: TextStyle(
            //           color: Color(0xffff0863),
            //           fontSize: 12,
            //           fontWeight: FontWeight.w700,
            //           letterSpacing: 1.3),
            //     ),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     Text(
            //       "08:00 AM",
            //       style: TextStyle(
            //           color: Color(0xff2d386b),
            //           fontSize: 30,
            //           fontWeight: FontWeight.w700),
            //     )
            //   ],
            // ),
          ],
        )
      ],
    );
  }
}
