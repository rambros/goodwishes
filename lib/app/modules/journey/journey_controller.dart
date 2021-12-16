import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/home_option_model.dart';
import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/user_service.dart';
import 'package:mobx/mobx.dart';

part 'journey_controller.g.dart';

class JourneyController = _JourneyController with _$JourneyController;

abstract class _JourneyController with Store {
  final _authenticationService = Modular.get<AuthenticationService>();
  final _userService = Modular.get<UserService>();

  final List<HomeOption> _listHomeOptions = [
     HomeOption(
       text: 'Escolher uma meditação',
       urlDestino: '/journey/list', 
       colorStart: Colors.blue[200],
       colorEnd: Colors.blue[400],
       icon: Icons.filter_vintage,),
    HomeOption(
       text: 'Meditar com Timer',
       urlDestino: '/journey/timer', 
       colorStart: Colors.orange[200],
       colorEnd: Colors.orange[500],
       icon: Icons.timer,),
    HomeOption(
       text: 'Meditação com vídeo',
       urlDestino: '/journey/video/list', 
       colorStart: Colors.pink[200],
       colorEnd: Colors.pink[400],
       icon: Icons.ondemand_video,),
    HomeOption(
       text: 'Estatísticas da meditação',
       urlDestino: '/journey/statistics', 
       colorStart: Colors.red[200],
       colorEnd: Colors.red[500],
       icon: Icons.poll,),
    HomeOption(
       text: 'Aprender a meditar',
       urlDestino: '/journey/course', 
       colorStart: Colors.green[200],
       colorEnd: Colors.green[400],
       icon: Icons.spa,),
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
     if ( _userService.userRole == 'Admin' && _listHomeOptions.length == 5  ) {
         _listHomeOptions.add(HomeOption(
              text: 'Edição de Meditações',
              urlDestino: '/journey/draft/list', 
              colorStart: Colors.cyan[200],
              colorEnd: Colors.cyan[400],
              icon: Icons.spa));        
     }
  }

  void logoff(){
    Modular.get<AuthenticationService>().logout();
    Modular.to.pushReplacementNamed('/login');
  }

}