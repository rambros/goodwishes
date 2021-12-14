import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/services/notification_service.dart';
import '../app_controller.dart';
import 'base_controller.dart';

class BasePage extends StatefulWidget {
  //final int tab;
  const BasePage({
    Key? key,
  }) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends ModularState<BasePage, BaseController> {
  final _appSettings = Modular.get<AppController>();

  @override
  void initState() {
    controller.init();
    Future.delayed(Duration(milliseconds: 0))
    .then((value) async{
      final _notificationService = NotificationService();
      await _notificationService.initFirebasePushNotification(context)
      .then((value) => _notificationService.handleNotificationlength());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (BuildContext context) {
          return controller.bodyViews.elementAt(controller.currentIndex);
        },
      ),

      bottomNavigationBar: Observer(
        builder: (BuildContext context) {
          return BottomNavigationBar(
            currentIndex: controller.currentIndex,
            selectedItemColor:  _appSettings.isDarkTheme! 
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            unselectedItemColor: _appSettings.isDarkTheme! 
                  ? Colors.white54
                  : Theme.of(context).colorScheme.primaryVariant,
            //type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            onTap: (index) {
              controller.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon/assistir_palestra.png'),
                      size: 30),
                label: 'Fundamentals',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon/meditar.png'),
                      size: 42),
                label: 'Journey',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon/mensagens.png'),
                      size: 30),
                label: 'Community',
              ),
            ],
          );
        },
      ),
    );
  }
}
