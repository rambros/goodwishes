import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/notifications_widget.dart';
import '../controller/notification_controller.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends ModularState<NotificationPage, NotificationController> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Notificações'),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh, size: 22,),
              onPressed: ()async{
                controller.onRefresh();
              },
            )
          ],
      ),
      body: NotificationsWidget(),
    );
  }
  

}


