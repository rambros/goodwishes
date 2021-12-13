import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'theme_controller.g.dart';

class ThemeController = _ThemeControllerBase with _$ThemeController;

abstract class _ThemeControllerBase with Store {
  
@observable
ThemeData? _currentTheme;

ThemeData? get currentTheme => _currentTheme;

@action
void setTheme(ThemeData newTheme) => _currentTheme = newTheme;

}