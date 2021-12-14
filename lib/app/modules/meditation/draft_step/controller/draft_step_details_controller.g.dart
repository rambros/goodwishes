// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_step_details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DraftStepDetailsController on _DraftStepDetailsControllerBase, Store {
  Computed<String>? _$numPlayedComputed;

  @override
  String get numPlayed =>
      (_$numPlayedComputed ??= Computed<String>(() => super.numPlayed,
              name: '_DraftStepDetailsControllerBase.numPlayed'))
          .value;
  Computed<String>? _$numLikedComputed;

  @override
  String get numLiked =>
      (_$numLikedComputed ??= Computed<String>(() => super.numLiked,
              name: '_DraftStepDetailsControllerBase.numLiked'))
          .value;
  Computed<ObservableList<Comment>?>? _$commentsComputed;

  @override
  ObservableList<Comment>? get comments => (_$commentsComputed ??=
          Computed<ObservableList<Comment>?>(() => super.comments,
              name: '_DraftStepDetailsControllerBase.comments'))
      .value;
  Computed<int>? _$numCommentsComputed;

  @override
  int get numComments =>
      (_$numCommentsComputed ??= Computed<int>(() => super.numComments,
              name: '_DraftStepDetailsControllerBase.numComments'))
          .value;

  final _$_stepAtom = Atom(name: '_DraftStepDetailsControllerBase._step');

  @override
  StepModel? get _step {
    _$_stepAtom.reportRead();
    return super._step;
  }

  @override
  set _step(StepModel? value) {
    _$_stepAtom.reportWrite(value, super._step, () {
      super._step = value;
    });
  }

  final _$_numPlayedAtom =
      Atom(name: '_DraftStepDetailsControllerBase._numPlayed');

  @override
  int? get _numPlayed {
    _$_numPlayedAtom.reportRead();
    return super._numPlayed;
  }

  @override
  set _numPlayed(int? value) {
    _$_numPlayedAtom.reportWrite(value, super._numPlayed, () {
      super._numPlayed = value;
    });
  }

  final _$_numLikedAtom =
      Atom(name: '_DraftStepDetailsControllerBase._numLiked');

  @override
  int? get _numLiked {
    _$_numLikedAtom.reportRead();
    return super._numLiked;
  }

  @override
  set _numLiked(int? value) {
    _$_numLikedAtom.reportWrite(value, super._numLiked, () {
      super._numLiked = value;
    });
  }

  final _$_favoriteMeditationAtom =
      Atom(name: '_DraftStepDetailsControllerBase._favoriteMeditation');

  @override
  bool? get _favoriteMeditation {
    _$_favoriteMeditationAtom.reportRead();
    return super._favoriteMeditation;
  }

  @override
  set _favoriteMeditation(bool? value) {
    _$_favoriteMeditationAtom.reportWrite(value, super._favoriteMeditation, () {
      super._favoriteMeditation = value;
    });
  }

  final _$_busyAtom = Atom(name: '_DraftStepDetailsControllerBase._busy');

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

  final _$_DraftStepDetailsControllerBaseActionController =
      ActionController(name: '_DraftStepDetailsControllerBase');

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_DraftStepDetailsControllerBaseActionController
        .startAction(name: '_DraftStepDetailsControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_DraftStepDetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
numPlayed: ${numPlayed},
numLiked: ${numLiked},
comments: ${comments},
numComments: ${numComments}
    ''';
  }
}
