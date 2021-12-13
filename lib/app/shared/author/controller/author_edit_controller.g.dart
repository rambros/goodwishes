// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthorEditController on _AuthorEditControllerBase, Store {
  final _$_busyAtom = Atom(name: '_AuthorEditControllerBase._busy');

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

  final _$_AuthorEditControllerBaseActionController =
      ActionController(name: '_AuthorEditControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_AuthorEditControllerBaseActionController
        .startAction(name: '_AuthorEditControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_AuthorEditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
