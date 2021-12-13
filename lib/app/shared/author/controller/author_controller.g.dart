// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthorController on _AuthorControllerBase, Store {
  final _$_busyAtom = Atom(name: '_AuthorControllerBase._busy');

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

  final _$_listAuthorsAtom = Atom(name: '_AuthorControllerBase._listAuthors');

  @override
  List<UserApp>? get _listAuthors {
    _$_listAuthorsAtom.reportRead();
    return super._listAuthors;
  }

  @override
  set _listAuthors(List<UserApp>? value) {
    _$_listAuthorsAtom.reportWrite(value, super._listAuthors, () {
      super._listAuthors = value;
    });
  }

  final _$_AuthorControllerBaseActionController =
      ActionController(name: '_AuthorControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_AuthorControllerBaseActionController.startAction(
        name: '_AuthorControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_AuthorControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
