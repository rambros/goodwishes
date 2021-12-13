// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_music_sel_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimerMusicSelController on _TimerMusicSelControllerBase, Store {
  final _$_busyAtom = Atom(name: '_TimerMusicSelControllerBase._busy');

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

  final _$_timerMusicsAtom =
      Atom(name: '_TimerMusicSelControllerBase._timerMusics');

  @override
  List<TimerMusic> get _timerMusics {
    _$_timerMusicsAtom.reportRead();
    return super._timerMusics;
  }

  @override
  set _timerMusics(List<TimerMusic> value) {
    _$_timerMusicsAtom.reportWrite(value, super._timerMusics, () {
      super._timerMusics = value;
    });
  }

  final _$_selectedItemAtom =
      Atom(name: '_TimerMusicSelControllerBase._selectedItem');

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

  final _$_TimerMusicSelControllerBaseActionController =
      ActionController(name: '_TimerMusicSelControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_TimerMusicSelControllerBaseActionController
        .startAction(name: '_TimerMusicSelControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_TimerMusicSelControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedMusic(dynamic index) {
    final _$actionInfo = _$_TimerMusicSelControllerBaseActionController
        .startAction(name: '_TimerMusicSelControllerBase.setSelectedMusic');
    try {
      return super.setSelectedMusic(index);
    } finally {
      _$_TimerMusicSelControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
