import 'dart:async';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late SharedPreferences _preferences;
  Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  init() async {
    _preferences = await SharedPreferences.getInstance();
    _instance.complete(await SharedPreferences.getInstance());
  }


  //bool isDarkTheme
  String isDarkThemeKey = 'isDarkTheme'; 

  set isDarkTheme(bool value) => _preferences.setBool(isDarkThemeKey, value);

  bool get isDarkTheme =>  _preferences.getBool(isDarkThemeKey)!;
  
  Future getTheme() async {
    var sp = await _instance.future;
    return sp.get(isDarkThemeKey);
  }

  // Future _getPreferences() async {
  //   //var sp = await _instance.future;
  //   _isDarkTheme = _sp.get(isDarkThemeKey);

  // }

  // Future setPreferences() async {
  //   //var sp = await _instance.future;
  //   _sp.setBool(isDarkThemeKey, _isDarkTheme);
  // }

  //set isDarkTheme(value) => _saveToDisk(isDarkThemeKey, value );  // _isDarkTheme = value;
  //bool get isDarkTheme => _getFromDisk(isDarkThemeKey).cast<bool>() ?? false;  // _isDarkTheme ?? false;  //_isDarkTheme;
  
  // bool get isDarkTheme {
  //   var temp = _getFromDisk(isDarkThemeKey);
  //   //var sp = await _instance.future;
  //   var value = _sp.get(isDarkThemeKey);
  //   _isDarkTheme = value;
  //   //return temp.cast<bool>() ?? false;
  //   return value;
  // }

  // getListaIndicesMensagensDia()  {
  //   List<String> result = _getFromDisk('listaIndicesMensagens');
  //   if (result == null) {
  //      _saveToDisk('listaIndicesMensagens', []);
  //      return [];
  //   }
  //   return result;
  // }

    Future<List<String>> getListaIndicesMensagensDia() async {
    var sp = await SharedPreferences.getInstance();
    var result = sp.getStringList('listaIndicesMensagens');
    if (result == null) {
      await sp.setStringList('listaIndicesMensagens', []);
       return [];
    }
    return result;
  }

   void setListaIndicesMensagensDia(value) {
    return _saveToDisk('listaIndicesMensagens', value);  
  } 

  dynamic getIndexMensagemHoje() async {
    var sp = await SharedPreferences.getInstance();
    return sp.getInt('indexMensagemHoje');
  }

  void setIndexMensagemHoje(value) {
    return _saveToDisk('indexMensagemHoje', value);
  }

  dynamic getDataHojeSalva() async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString('dataHoje');
  }

  void setDataHojeSalva(value) async {
      var sp = await SharedPreferences.getInstance();
      await sp.setString('dataHoje', value);
  }


  dynamic _getFromDisk(String key) async {
    var sp = await SharedPreferences.getInstance();
    var value = sp.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) async {
    var _sp = await SharedPreferences.getInstance();
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      await _sp.setString(key, content);
    }
    if (content is bool) {
      await _sp.setBool(key, content);
    }
    if (content is int) {
      await _sp.setInt(key, content);
    }
    if (content is double) {
      await _sp.setDouble(key, content);
    }
    if (content is List<String>) {
      await _sp.setStringList(key, content);
    }
  }
}
