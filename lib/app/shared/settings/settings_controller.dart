
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../app_controller.dart';

part 'settings_controller.g.dart';

class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  final _appSettings = Modular.get<AppController>();

  @observable
  bool? _isDarkTheme;

  String isDarkThemeKey = 'isDarkTheme';

  bool? get isDarkTheme => _appSettings.isDarkTheme;

  void setDarkTheme (value) => _appSettings.setDarkTheme(value);


  @observable
  bool _busy = false;
  bool get busy => _busy;

  @action
  void setBusy(bool value) {
    _busy = value;
  }
}
