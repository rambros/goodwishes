// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationController on _NotificationControllerBase, Store {
  final _$_busyAtom = Atom(name: '_NotificationControllerBase._busy');

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

  final _$_dataAtom = Atom(name: '_NotificationControllerBase._data');

  @override
  List<NotificationModel> get _data {
    _$_dataAtom.reportRead();
    return super._data;
  }

  @override
  set _data(List<NotificationModel> value) {
    _$_dataAtom.reportWrite(value, super._data, () {
      super._data = value;
    });
  }

  final _$_hasDataAtom = Atom(name: '_NotificationControllerBase._hasData');

  @override
  bool? get _hasData {
    _$_hasDataAtom.reportRead();
    return super._hasData;
  }

  @override
  set _hasData(bool? value) {
    _$_hasDataAtom.reportWrite(value, super._hasData, () {
      super._hasData = value;
    });
  }

  final _$_NotificationControllerBaseActionController =
      ActionController(name: '_NotificationControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_NotificationControllerBaseActionController
        .startAction(name: '_NotificationControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_NotificationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onRefresh() {
    final _$actionInfo = _$_NotificationControllerBaseActionController
        .startAction(name: '_NotificationControllerBase.onRefresh');
    try {
      return super.onRefresh();
    } finally {
      _$_NotificationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
