// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  Computed<bool?>? _$isDarkThemeComputed;

  @override
  bool? get isDarkTheme =>
      (_$isDarkThemeComputed ??= Computed<bool?>(() => super.isDarkTheme,
              name: '_AppControllerBase.isDarkTheme'))
          .value;
  Computed<ThemeData?>? _$currentThemeComputed;

  @override
  ThemeData? get currentTheme =>
      (_$currentThemeComputed ??= Computed<ThemeData?>(() => super.currentTheme,
              name: '_AppControllerBase.currentTheme'))
          .value;

  final _$_isDarkThemeAtom = Atom(name: '_AppControllerBase._isDarkTheme');

  @override
  bool? get _isDarkTheme {
    _$_isDarkThemeAtom.reportRead();
    return super._isDarkTheme;
  }

  @override
  set _isDarkTheme(bool? value) {
    _$_isDarkThemeAtom.reportWrite(value, super._isDarkTheme, () {
      super._isDarkTheme = value;
    });
  }

  final _$_currentThemeAtom = Atom(name: '_AppControllerBase._currentTheme');

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

  final _$setDarkThemeAsyncAction =
      AsyncAction('_AppControllerBase.setDarkTheme');

  @override
  Future<dynamic> setDarkTheme(dynamic value) {
    return _$setDarkThemeAsyncAction.run(() => super.setDarkTheme(value));
  }

  final _$_AppControllerBaseActionController =
      ActionController(name: '_AppControllerBase');

  @override
  void changeTheme(ThemeData value) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.changeTheme');
    try {
      return super.changeTheme(value);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkTheme: ${isDarkTheme},
currentTheme: ${currentTheme}
    ''';
  }
}
