import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/user_service.dart';
import 'community/community_page.dart';
import 'fundamentals/fundamentals_page.dart';
import 'journeys/journey_base_page.dart';
import 'journeys/step/repository/step_firebase_controller.dart';

part 'base_controller.g.dart';

class BaseController = _BaseControllerBase with _$BaseController;

abstract class _BaseControllerBase with Store {
  final _authenticationService = Modular.get<AuthenticationService>();
  final _userService = Modular.get<UserService>();
  final _stepFirebaseController = Modular.get<StepFirebaseController>();

  final List<Widget> _bodyViews = <Widget>[
    FundamentalsPage(),
    JourneyBasePage(),
    CommunityPage(),
  ];


  List<Widget> get bodyViews => _bodyViews;

  @observable
  int? _currentIndex = 1;

  @action
  void changeIndex(int value) => _currentIndex = value;

  @computed
  int get currentIndex => _currentIndex?? 0;


   void init()  {
     _stepFirebaseController.listenToSteps();
     final fbUser = _authenticationService.currentAuthUser;
     if (fbUser != null) {
        final dynamic userValid = _userService.populateCurrentUser(fbUser);
        if (userValid == null) {
          logoff();
        }
     }
  }

  void logoff(){
    Modular.get<AuthenticationService>().logout();
    Modular.to.navigate('/login/sociallogin');
  }

}