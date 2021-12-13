// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conhecimento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConhecimentoController on _ConhecimentoController, Store {
  Computed<int>? _$currentIndexComputed;

  @override
  int get currentIndex =>
      (_$currentIndexComputed ??= Computed<int>(() => super.currentIndex,
              name: '_ConhecimentoController.currentIndex'))
          .value;

  final _$_currentIndexAtom =
      Atom(name: '_ConhecimentoController._currentIndex');

  @override
  int? get _currentIndex {
    _$_currentIndexAtom.reportRead();
    return super._currentIndex;
  }

  @override
  set _currentIndex(int? value) {
    _$_currentIndexAtom.reportWrite(value, super._currentIndex, () {
      super._currentIndex = value;
    });
  }

  final _$_ConhecimentoControllerActionController =
      ActionController(name: '_ConhecimentoController');

  @override
  void changeIndex(int value) {
    final _$actionInfo = _$_ConhecimentoControllerActionController.startAction(
        name: '_ConhecimentoController.changeIndex');
    try {
      return super.changeIndex(value);
    } finally {
      _$_ConhecimentoControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex}
    ''';
  }
}
