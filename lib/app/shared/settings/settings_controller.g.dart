// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsControllerBase, Store {
  final _$_isDarkThemeAtom = Atom(name: '_SettingsControllerBase._isDarkTheme');

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

  final _$_busyAtom = Atom(name: '_SettingsControllerBase._busy');

  @override
  bool get _busy {
    _$_busyAtom.reportRead();
    return super._busy;
  }

  @override
  set _busy(bool value) {
    _$_busyAtom.reportWrite(value, super._busy, () {
      super._busy = value;
    });
  }

  final _$_SettingsControllerBaseActionController =
      ActionController(name: '_SettingsControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
        name: '_SettingsControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
