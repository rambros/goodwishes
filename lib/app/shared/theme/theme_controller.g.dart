// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeController on _ThemeControllerBase, Store {
  final _$_currentThemeAtom = Atom(name: '_ThemeControllerBase._currentTheme');

  @override
  ThemeData? get _currentTheme {
    _$_currentThemeAtom.reportRead();
    return super._currentTheme;
  }

  @override
  set _currentTheme(ThemeData? value) {
    _$_currentThemeAtom.reportWrite(value, super._currentTheme, () {
      super._currentTheme = value;
    });
  }

  final _$_ThemeControllerBaseActionController =
      ActionController(name: '_ThemeControllerBase');

  @override
  void setTheme(ThemeData newTheme) {
    final _$actionInfo = _$_ThemeControllerBaseActionController.startAction(
        name: '_ThemeControllerBase.setTheme');
    try {
      return super.setTheme(newTheme);
    } finally {
      _$_ThemeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
