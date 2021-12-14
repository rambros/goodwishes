import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/home_option_model.dart';
import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/user_service.dart';
import 'package:mobx/mobx.dart';

part 'video_controller.g.dart';

class VideoController = _VideoController with _$VideoController;

abstract class _VideoController with Store {
  final _authenticationService = Modular.get<AuthenticationService>();
  final _userService = Modular.get<UserService>();
  //final _analytics =  Modular.get<AnalyticsService>();


  final List<HomeOption> _listHomeOptions = [
     HomeOption(
       text: 'Canal Viver e Meditar',
       urlDestino: '/video/canalviver/list', 
       colorStart: Colors.blue[200],
       colorEnd: Colors.blue[400],
       icon: Icons.filter_vintage,),
    HomeOption(
       text: 'Palestras',
       urlDestino: '/video/palestra/list', 
       colorStart: Colors.teal[200],
       colorEnd: Colors.teal[400],
       icon: Icons.search,),
    HomeOption(
       text: 'Congresso de Raja Yoga',
       urlDestino: '/video/congresso/yoga',  
       colorStart: Colors.pink[200],
       colorEnd: Colors.pink[400],
       icon: Icons.spa,),
    HomeOption(
       text: 'Entrevistas',
       urlDestino: '/video/entrevista/list', 
       colorStart: Colors.green[200],
       colorEnd: Colors.green[400],
       icon: Icons.ondemand_video,),

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