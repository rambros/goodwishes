import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_controller.dart';

Widget HomeAppBar({BuildContext? context, required String title}) {
  final _appSettings = Modular.get<AppController>();
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: Container(),
    title: Text(
      title,
      style: TextStyle(
                  color: _appSettings.isDarkTheme! 
                  ? Colors.white
                  : Colors.black,//color: Theme.of(context).accentColor, 
                fontSize: 24),
    ),
    centerTitle: true,
    // leading: IconButton(
    //   padding: EdgeInsets.only(left: 2.0),
    //   icon: Icon(
    //     Icons.home,
    //     size: 28.0,
    //     color: Theme.of(context).accentColor,
    //   ),
    //   onPressed: () {
    //     Modular.to.pushReplacementNamed('/');
    //   },
    // ),
    actions: <Widget>[
      IconButton(
        padding: EdgeInsets.only(right: 18.0),
        icon: Icon(
          Icons.menu,
          size: 28.0,
          color:  _appSettings.isDarkTheme! 
                  ? Colors.white
                  : Colors.black,
        ),
        onPressed: () {
          Modular.to.pushNamed('/config');
          //Navigator.push( context, MaterialPageRoute( builder: (context) => SecondPage()), ).then((value) => setState(() {}));
        },
      ),
    ],
  );
}
