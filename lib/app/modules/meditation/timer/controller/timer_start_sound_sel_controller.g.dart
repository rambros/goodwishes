// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_start_sound_sel_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimerStartSoundSelController
    on _TimerStartSoundSelControllerBase, Store {
  final _$_busyAtom = Atom(name: '_TimerStartSoundSelControllerBase._busy');

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

  final _$_selectedItemAtom =
      Atom(name: '_TimerStartSoundSelControllerBase._selectedItem');

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

  final _$_TimerStartSoundSelControllerBaseActionController =
      ActionController(name: '_TimerStartSoundSelControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_TimerStartSoundSelControllerBaseActionController
        .startAction(name: '_TimerStartSoundSelControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_TimerStartSoundSelControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedStartSound(dynamic index) {
    final _$actionInfo =
        _$_TimerStartSoundSelControllerBaseActionController.startAction(
            name: '_TimerStartSoundSelControllerBase.setSelectedStartSound');
    try {
      return super.setSelectedStartSound(index);
    } finally {
      _$_TimerStartSoundSelControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
