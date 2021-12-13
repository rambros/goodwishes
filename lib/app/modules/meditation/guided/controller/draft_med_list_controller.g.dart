// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../draft_meditation/controller/draft_med_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DraftMeditationListController
    on _DraftMeditationListControllerBase, Store {
  final _$_busyAtom = Atom(name: '_DraftMeditationListControllerBase._busy');

  @override
  bool get _busy {
    _$_busyAtom.context.enforceReadPolicy(_$_busyAtom);
    _$_busyAtom.reportObserved();
    return super._busy;
  }

  @override
  set _busy(bool value) {
    _$_busyAtom.context.conditionallyRunInAction(() {
      super._busy = value;
      _$_busyAtom.reportChanged();
    }, _$_busyAtom, name: '${_$_busyAtom.name}_set');
  }

  final _$_draftMeditationsAtom =
      Atom(name: '_DraftMeditationListControllerBase._draftMeditations');

  @override
  List<Meditation>? get _draftMeditations {
    _$_draftMeditationsAtom.context.enforceReadPolicy(_$_draftMeditationsAtom);
    _$_draftMeditationsAtom.reportObserved();
    return super._draftMeditations;
  }

  @override
  set _draftMeditations(List<Meditation>? value) {
    _$_draftMeditationsAtom.context.conditionallyRunInAction(() {
      super._draftMeditations = value;
      _$_draftMeditationsAtom.reportChanged();
    }, _$_draftMeditationsAtom, name: '${_$_draftMeditationsAtom.name}_set');
  }

  final _$_draftMeditationsFilteredAtom = Atom(
      name: '_DraftMeditationListControllerBase._draftMeditationsFiltered');

  @override
  List<Meditation>? get _draftMeditationsFiltered {
    _$_draftMeditationsFilteredAtom.context
        .enforceReadPolicy(_$_draftMeditationsFilteredAtom);
    _$_draftMeditationsFilteredAtom.reportObserved();
    return super._draftMeditationsFiltered;
  }

  @override
  set _draftMeditationsFiltered(List<Meditation>? value) {
    _$_draftMeditationsFilteredAtom.context.conditionallyRunInAction(() {
      super._draftMeditationsFiltered = value;
      _$_draftMeditationsFilteredAtom.reportChanged();
    }, _$_draftMeditationsFilteredAtom,
        name: '${_$_draftMeditationsFilteredAtom.name}_set');
  }

  final _$_DraftMeditationListControllerBaseActionController =
      ActionController(name: '_DraftMeditationListControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo =
        _$_DraftMeditationListControllerBaseActionController.startAction();
    try {
      return super.setBusy(value);
    } finally {
      _$_DraftMeditationListControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = '';
    return '{$string}';
  }
}
