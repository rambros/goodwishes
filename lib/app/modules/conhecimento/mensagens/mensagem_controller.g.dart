// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensagem_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MensagemController on _MensagemControllerBase, Store {
  final _$_isLoadingAtom = Atom(name: '_MensagemControllerBase._isLoading');

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  final _$_mensagensListAtom =
      Atom(name: '_MensagemControllerBase._mensagensList');

  @override
  List<Mensagem>? get _mensagensList {
    _$_mensagensListAtom.reportRead();
    return super._mensagensList;
  }

  @override
  set _mensagensList(List<Mensagem>? value) {
    _$_mensagensListAtom.reportWrite(value, super._mensagensList, () {
      super._mensagensList = value;
    });
  }

  final _$_MensagemControllerBaseActionController =
      ActionController(name: '_MensagemControllerBase');

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_MensagemControllerBaseActionController.startAction(
        name: '_MensagemControllerBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_MensagemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
