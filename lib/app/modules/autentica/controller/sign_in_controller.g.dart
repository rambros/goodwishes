// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInController on _SignInControllerBase, Store {
  final _$signInStartAtom = Atom(name: '_SignInControllerBase.signInStart');

  @override
  bool get signInStart {
    _$signInStartAtom.reportRead();
    return super.signInStart;
  }

  @override
  set signInStart(bool value) {
    _$signInStartAtom.reportWrite(value, super.signInStart, () {
      super.signInStart = value;
    });
  }

  final _$signInCompleteAtom =
      Atom(name: '_SignInControllerBase.signInComplete');

  @override
  bool get signInComplete {
    _$signInCompleteAtom.reportRead();
    return super.signInComplete;
  }

  @override
  set signInComplete(bool value) {
    _$signInCompleteAtom.reportWrite(value, super.signInComplete, () {
      super.signInComplete = value;
    });
  }

  @override
  String toString() {
    return '''
signInStart: ${signInStart},
signInComplete: ${signInComplete}
    ''';
  }
}
