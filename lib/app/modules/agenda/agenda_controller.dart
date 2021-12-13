import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/home/home_option_model.dart';
import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/user_service.dart';
import 'package:mobx/mobx.dart';

part 'agenda_controller.g.dart';

class AgendaController = _AgendaController with _$AgendaController;

abstract class _AgendaController with Store {
  final _authenticationService = Modular.get<AuthenticationService>();
  final _userService = Modular.get<UserService>();


  final List<HomeOption> _listHomeOptions = [
     HomeOption(
       text: 'Ver agenda mensal',
       urlDestino: '/agenda/list', 
       colorStart: Colors.blue[200],
       colorEnd: Colors.blue[400],
       icon: Icons.filter_vintage,),
    HomeOption(
       text: 'Lista de Cursos e Workshops',
       urlDestino: '/agenda/event/list', 
       colorStart: Colors.red[200],
       colorEnd: Colors.red[600],
       icon: Icons.search,),
    // HomeOption(
    //    text: 'Visualizar o site',
    //    urlDestino: '/agenda/site/list', 
    //    color: Colors.pink[200],
    //    icon: Icons.spa,),
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