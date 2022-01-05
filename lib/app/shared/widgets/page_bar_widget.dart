import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_controller.dart';

class PageBar extends StatefulWidget with PreferredSizeWidget {
  final String? title;

  PageBar({this.title});
  @override
  _PageBarState createState() => _PageBarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _PageBarState extends State<PageBar> {

  @override
  Widget build(BuildContext context) {
  final _appSettings = Modular.get<AppController>();
  //final _notificationService = Modular.get<NotificationService>();
  return AppBar(
    leading: IconButton(
        padding: EdgeInsets.only(left: 18, right: 18.0),
        icon: Icon(
          Icons.menu,
          size: 28.0,
          color:  _appSettings.isDarkTheme! 
                  ? Colors.white
                  : Colors.black,
        ),
        onPressed: () {
          Modular.to.pushNamed('/config').then((value) => setState((){}));
        },
      ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Text(
      widget.title!,
      style: TextStyle(
                  color: _appSettings.isDarkTheme! 
                  ? Colors.white
                  : Colors.black,//color: Theme.of(context).accentColor, 
                fontSize: 24),
    ),
    centerTitle: true,
    actions: <Widget>[
      // Badge(
      //   position: BadgePosition.topEnd(top: 0, end: 6),
      //   padding: EdgeInsets.all(6),
      //   badgeColor: Colors.redAccent,
      //   animationType: BadgeAnimationType.fade,
      //   showBadge: _notificationService.savedNlength < _notificationService.notificationLength
      //       ? true
      //       : false,
      //   badgeContent: Text(
      //       _totalNotifications.toString(),
      //       style: TextStyle(fontSize: 12),
      //   ),
      //   child: IconButton(
      //     padding: EdgeInsets.all(4.0),
      //     icon: Icon(
      //       Icons.notifications_none,
      //       size: 28.0,
      //       color:  _appSettings.isDarkTheme 
      //               ? Colors.white
      //               : Colors.black54,
      //     ),
      //     onPressed: () {
      //       _notificationService.saveNlengthToSP();
      //       Modular.to.pushNamed('/notification').then((value) => setState((){}));
      //     },
      //   ),
      // ),
      IconButton(
        padding: EdgeInsets.only(right: 18.0),
        icon: Icon(
          Icons.notifications_none,
          size: 28.0,
          color:  _appSettings.isDarkTheme! 
                  ? Colors.white
                  : Colors.black54,
        ),
        onPressed: () {
          Modular.to.pushNamed('/notification').then((value) => setState((){}));
        },
      ),
    ],
  );
  }
}