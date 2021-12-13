import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/user_service.dart';
import 'package:mobx/mobx.dart';

import 'home_option_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  final _authenticationService = Modular.get<AuthenticationService>();
  final _userService = Modular.get<UserService>();
  //final _analytics =  Modular.get<AnalyticsService>();


  final List<HomeOption> _listHomeOptions = [
     HomeOption(
      text: 'Fazer uma meditação',
       urlDestino: '/meditation/list',
       colorStart: Colors.pink[200],
       colorEnd: Colors.pink[400],
       icon: Icons.filter_vintage,),
    HomeOption(
       text: 'Ver a agenda de atividades',
       urlDestino: '/agenda/event/list', 
       colorStart: Colors.red[200], 
       colorEnd: Colors.red[500],
       icon: Icons.calendar_today,),
    HomeOption(
       text: 'Ler mensagem para o dia',
       urlDestino: '/conhecimento/mensagemDetails', 
       colorStart: Colors.orange[200],
       colorEnd: Colors.orange[400],
       icon: Icons.spa,),
    HomeOption(
       text: 'Ajude-nos a melhorar o app',
       urlDestino: '/support', 
       colorStart: Colors.yellow[400],
       colorEnd: Colors.yellow[800],
       icon: Icons.ondemand_video,),
    // HomeOption(
    //    text: 'Assistir vídeo Viver e Meditar',
    //    urlDestino: '/video/canalviver/list', 
    //    colorStart: Colors.red[200],
    //    colorEnd: Colors.red[400],
    //    icon: Icons.ondemand_video,),
    // HomeOption(
    //    text: 'Compartilhar com amigos',
    //    urlDestino: '/invite', 
    //    color: Colors.purple[200],
    //    icon: Icons.share,),
    // HomeOption(
    //    text: 'Alterar Configurações',
    //    urlDestino: '/config', 
    //    color: Colors.blueGrey[400],
    //    icon: Icons.settings,),


  ];

  List<HomeOption> get listHomeOptions => _listHomeOptions;

  @observable
  int? _currentIndex;

  @action
  void changeIndex(int value) => _currentIndex = value;

  @computed
  int get currentIndex => _currentIndex?? 0;


   void init()  {
    //_analytics.setCurrentScreen(screenName: '/home');
    //_analytics.logAccessPage(page: 'Módulo Home');

     final fbUser = _authenticationService.currentAuthUser;
     if (fbUser != null) {
        var userValid = _userService.populateCurrentUser(fbUser);
        if (userValid == null) {
          logoff();
        }
     }
  }

  void logoff(){
    Modular.get<AuthenticationService>().logout();
    Modular.to.pushReplacementNamed('/login');
  }

}