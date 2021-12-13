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
      //appBar: AppBar(
      //   title: Text('Home'),
      //   leading: IconButton(icon: Icon(Icons.highlight_off), onPressed: (){
      //     controller.logoff();
      //   })
      //),
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
                  : Colors.black87,
            unselectedItemColor: _appSettings.isDarkTheme! 
                  ? Colors.white54
                  : Colors.black38,
            //type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            onTap: (index) {
              controller.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon/home.png'),
                      size: 23),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon/mensagens.png'),
                      size: 30),
                label: 'Mensagens',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon/meditar.png'),
                      size: 42),
                label: 'Meditações',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon/assistir_palestra.png'),
                      size: 30),
                label: 'Videos',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon/agenda.png'),
                      size: 25),
                label: 'Agenda',
              )
            ],
          );
        },
      ),
    );
  }
}
