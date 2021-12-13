// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'med_results_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeditationResultsController on _MeditationResultsControllerBase, Store {
  final _$_busyAtom = Atom(name: '_MeditationResultsControllerBase._busy');

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
      Atom(name: '_MeditationResultsControllerBase._meditations');

  @override
  List<Meditation>? get _meditations {
    _$_meditationsAtom.reportRead();
    return super._meditations;
  }

  @override
  set _meditations(List<Meditation>? value) {
    _$_meditationsAtom.reportWrite(value, super._meditations, () {
      super._meditations = value;
    });
  }

  final _$_MeditationResultsControllerBaseActionController =
      ActionController(name: '_MeditationResultsControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_MeditationResultsControllerBaseActionController
        .startAction(name: '_MeditationResultsControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_MeditationResultsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
