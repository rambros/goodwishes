import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/app/shared/services/user_service.dart';
import 'shared/theme/theme_data.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final Completer<SharedPreferences> _instance = Completer<SharedPreferences>();
  final _userService = Modular.get<UserService>();

  @observable
  bool? _isDarkTheme;

  void _init() async {
    _isDarkTheme = false;
    _instance.complete(await SharedPreferences.getInstance());
    final _auth = FirebaseAuth.instance;
    final _firebaseUser = _auth.currentUser;
    if (_firebaseUser == null) {
      _userService.setUserApp(null);
    } else {
      await _userService.populateCurrentUser(_firebaseUser);
    }
  }

  _AppControllerBase() {
    _init();
    _getPreferences();
  }

  Future _getPreferences() async {
    var sp = await _instance.future;
    _isDarkTheme = sp.get(isDarkThemeKey) as bool? ?? false;
    if (_isDarkTheme == true) {
      //changeTheme(ThemeData.dark());
      changeTheme(basicDarkTheme());
    } else {
      // changeTheme(ThemeData.light());
      changeTheme(basicLightTheme());
    }
  }

  String isDarkThemeKey = 'isDarkTheme';

  @computed
  bool? get isDarkTheme => _isDarkTheme;

  @action
  Future setDarkTheme(value) async {
    _isDarkTheme = value;
    var sp = await _instance.future;
    await sp.setBool(isDarkThemeKey, value);

    if (_isDarkTheme == true) {
      //changeTheme(ThemeData.dark());
      changeTheme(basicDarkTheme());
    } else {
      //changeTheme(ThemeData.light());
      changeTheme(basicLightTheme());
    }
  }

  @observable
  ThemeData? _currentTheme;

  @action
  void changeTheme(ThemeData value) {
    _currentTheme = value;
  }

  @computed
  ThemeData? get currentTheme => _currentTheme;
}
