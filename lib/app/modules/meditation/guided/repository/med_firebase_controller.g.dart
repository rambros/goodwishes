// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'med_firebase_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeditationFirebaseController
    on _MeditationFirebaseControllerBase, Store {
  final _$_meditationsAtom =
      Atom(name: '_MeditationFirebaseControllerBase._meditations');

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

  final _$_meditationsDraftAtom =
      Atom(name: '_MeditationFirebaseControllerBase._meditationsDraft');

  @override
  List<Meditation> get _meditationsDraft {
    _$_meditationsDraftAtom.reportRead();
    return super._meditationsDraft;
  }

  @override
  set _meditationsDraft(List<Meditation> value) {
    _$_meditationsDraftAtom.reportWrite(value, super._meditationsDraft, () {
      super._meditationsDraft = value;
    });
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
