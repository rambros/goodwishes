// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_player_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimerPlayerController on _TimerPlayerControllerBase, Store {
  final _$_volumeAtom = Atom(name: '_TimerPlayerControllerBase._volume');

  @override
  double get _volume {
    _$_volumeAtom.reportRead();
    return super._volume;
  }

  @override
  set _volume(double value) {
    _$_volumeAtom.reportWrite(value, super._volume, () {
      super._volume = value;
    });
  }

  final _$_speedAtom = Atom(name: '_TimerPlayerControllerBase._speed');

  @override
  double get _speed {
    _$_speedAtom.reportRead();
    return super._speed;
  }

  @override
  set _speed(double value) {
    _$_speedAtom.reportWrite(value, super._speed, () {
      super._speed = value;
    });
  }

  final _$_positionAtom = Atom(name: '_TimerPlayerControllerBase._position');

  @override
  double get _position {
    _$_positionAtom.reportRead();
    return super._position;
  }

  @override
  set _position(double value) {
    _$_positionAtom.reportWrite(value, super._position, () {
      super._position = value;
    });
  }

  final _$_bufferingAtom = Atom(name: '_TimerPlayerControllerBase._buffering');

  @override
  double get _buffering {
    _$_bufferingAtom.reportRead();
    return super._buffering;
  }

  @override
  set _buffering(double value) {
    _$_bufferingAtom.reportWrite(value, super._buffering, () {
      super._buffering = value;
    });
  }

  final _$_busyAtom = Atom(name: '_TimerPlayerControllerBase._busy');

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

  final _$_TimerPlayerControllerBaseActionController =
      ActionController(name: '_TimerPlayerControllerBase');

  @override
  void setVolume(double value) {
    final _$actionInfo = _$_TimerPlayerControllerBaseActionController
        .startAction(name: '_TimerPlayerControllerBase.setVolume');
    try {
      return super.setVolume(value);
    } finally {
      _$_TimerPlayerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_TimerPlayerControllerBaseActionController
        .startAction(name: '_TimerPlayerControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_TimerPlayerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
