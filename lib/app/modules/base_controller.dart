import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '/app/shared/author/controller/author_controller.dart';
import '/app/shared/services/authentication_service.dart';
import '/app/shared/services/user_service.dart';
import 'category/category_controller.dart';
import 'conhecimento/conhecimento_page.dart';
import 'meditation/guided/page/med_list_page.dart';
import 'meditation/guided/repository/med_firebase_controller.dart';
import 'video/video_page.dart';

part 'base_controller.g.dart';

class BaseController = _BaseControllerBase with _$BaseController;

abstract class _BaseControllerBase with Store {
  final _categoryController = Modular.get<CategoryController>();
  final _authenticationService = Modular.get<AuthenticationService>();
  final _userService = Modular.get<UserService>();
  final _authorController = Modular.get<AuthorController>();
  final _medFirebaseController = Modular.get<MeditationFirebaseController>();

  final List<Widget> _bodyViews = <Widget>[
    ConhecimentoPage(),
    MeditationListPage(),
    VideoPage(),
  ];


  List<Widget> get bodyViews => _bodyViews;

  @observable
  int? _currentIndex;

  @action
  void changeIndex(int value) => _currentIndex = value;

  @computed
  int get currentIndex => _currentIndex?? 0;


   void init()  {
     _categoryController.listenToCategories();
     _medFirebaseController.listenToMeditations();
    // _draftStepFirebaseController.listenToDraftSteps();
     _authorController.getListAuthorsOnce();  
     
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
    Modular.to.navigate('/login/sociallogin');
  }

}