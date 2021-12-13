// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'med_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeditationListController on _MeditationListControllerBase, Store {
  final _$_busyAtom = Atom(name: '_MeditationListControllerBase._busy');

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

  final _$_meditationsAtom =
      Atom(name: '_MeditationListControllerBase._meditations');

  @override
  List<Meditation> get _meditations {
    _$_meditationsAtom.reportRead();
    return super._meditations;
  }

  @override
  set _meditations(List<Meditation> value) {
    _$_meditationsAtom.reportWrite(value, super._meditations, () {
      super._meditations = value;
    });
  }

  final _$_meditationsFilteredAtom =
      Atom(name: '_MeditationListControllerBase._meditationsFiltered');

  @override
  List<Meditation> get _meditationsFiltered {
    _$_meditationsFilteredAtom.reportRead();
    return super._meditationsFiltered;
  }

  @override
  set _meditationsFiltered(List<Meditation> value) {
    _$_meditationsFilteredAtom.reportWrite(value, super._meditationsFiltered,
        () {
      super._meditationsFiltered = value;
    });
  }

  final _$_MeditationListControllerBaseActionController =
      ActionController(name: '_MeditationListControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_MeditationListControllerBaseActionController
        .startAction(name: '_MeditationListControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_MeditationListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterByCategory(String? category) {
    final _$actionInfo = _$_MeditationListControllerBaseActionController
        .startAction(name: '_MeditationListControllerBase.filterByCategory');
    try {
      return super.filterByCategory(category);
    } finally {
      _$_MeditationListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
