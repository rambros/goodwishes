// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_add_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthorAddController on _AuthorAddControllerBase, Store {
  Computed<bool>? _$isAuthorSelectedComputed;

  @override
  bool get isAuthorSelected => (_$isAuthorSelectedComputed ??= Computed<bool>(
          () => super.isAuthorSelected,
          name: '_AuthorAddControllerBase.isAuthorSelected'))
      .value;

  final _$_busyAtom = Atom(name: '_AuthorAddControllerBase._busy');

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

  final _$authorAtom = Atom(name: '_AuthorAddControllerBase.author');

  @override
  UserApp? get author {
    _$authorAtom.reportRead();
    return super.author;
  }

  @override
  set author(UserApp? value) {
    _$authorAtom.reportWrite(value, super.author, () {
      super.author = value;
    });
  }

  final _$changeUserRoleAsyncAction =
      AsyncAction('_AuthorAddControllerBase.changeUserRole');

  @override
  Future<dynamic> changeUserRole(String? newUserRole) {
    return _$changeUserRoleAsyncAction
        .run(() => super.changeUserRole(newUserRole));
  }

  final _$_AuthorAddControllerBaseActionController =
      ActionController(name: '_AuthorAddControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_AuthorAddControllerBaseActionController.startAction(
        name: '_AuthorAddControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_AuthorAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearUser() {
    final _$actionInfo = _$_AuthorAddControllerBaseActionController.startAction(
        name: '_AuthorAddControllerBase.clearUser');
    try {
      return super.clearUser();
    } finally {
      _$_AuthorAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
author: ${author},
isAuthorSelected: ${isAuthorSelected}
    ''';
  }
}
