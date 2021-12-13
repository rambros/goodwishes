// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimerController on _TimerControllerBase, Store {
  final _$horasAtom = Atom(name: '_TimerControllerBase.horas');

  @override
  int get horas {
    _$horasAtom.reportRead();
    return super.horas;
  }

  @override
  set horas(int value) {
    _$horasAtom.reportWrite(value, super.horas, () {
      super.horas = value;
    });
  }

  final _$minutosAtom = Atom(name: '_TimerControllerBase.minutos');

  @override
  int get minutos {
    _$minutosAtom.reportRead();
    return super.minutos;
  }

  @override
  set minutos(int value) {
    _$minutosAtom.reportWrite(value, super.minutos, () {
      super.minutos = value;
    });
  }

  final _$segundosAtom = Atom(name: '_TimerControllerBase.segundos');

  @override
  int get segundos {
    _$segundosAtom.reportRead();
    return super.segundos;
  }

  @override
  set segundos(int value) {
    _$segundosAtom.reportWrite(value, super.segundos, () {
      super.segundos = value;
    });
  }

  final _$_busyAtom = Atom(name: '_TimerControllerBase._busy');

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

  final _$_selectedItemAtom = Atom(name: '_TimerControllerBase._selectedItem');

  @override
  int get _selectedItem {
    _$_selectedItemAtom.reportRead();
    return super._selectedItem;
  }

  @override
  set _selectedItem(int value) {
    _$_selectedItemAtom.reportWrite(value, super._selectedItem, () {
      super._selectedItem = value;
    });
  }

  final _$_TimerControllerBaseActionController =
      ActionController(name: '_TimerControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_TimerControllerBaseActionController.startAction(
        name: '_TimerControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_TimerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedItem(dynamic index) {
    final _$actionInfo = _$_TimerControllerBaseActionController.startAction(
        name: '_TimerControllerBase.setSelectedItem');
    try {
      return super.setSelectedItem(index);
    } finally {
      _$_TimerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getTitleStartSound() {
    final _$actionInfo = _$_TimerControllerBaseActionController.startAction(
        name: '_TimerControllerBase.getTitleStartSound');
    try {
      return super.getTitleStartSound();
    } finally {
      _$_TimerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getTitleEndSound() {
    final _$actionInfo = _$_TimerControllerBaseActionController.startAction(
        name: '_TimerControllerBase.getTitleEndSound');
    try {
      return super.getTitleEndSound();
    } finally {
      _$_TimerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getTitle() {
    final _$actionInfo = _$_TimerControllerBaseActionController.startAction(
        name: '_TimerControllerBase.getTitle');
    try {
      return super.getTitle();
    } finally {
      _$_TimerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
horas: ${horas},
minutos: ${minutos},
segundos: ${segundos}
    ''';
  }
}
