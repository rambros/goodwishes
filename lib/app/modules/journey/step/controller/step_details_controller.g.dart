// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StepDetailsController on _stepDetailsControllerBase, Store {
  Computed<String>? _$numPlayedComputed;

  @override
  String get numPlayed =>
      (_$numPlayedComputed ??= Computed<String>(() => super.numPlayed,
              name: '_stepDetailsControllerBase.numPlayed'))
          .value;
  Computed<String>? _$numLikedComputed;

  @override
  String get numLiked =>
      (_$numLikedComputed ??= Computed<String>(() => super.numLiked,
              name: '_stepDetailsControllerBase.numLiked'))
          .value;
  Computed<ObservableList<Comment>?>? _$commentsComputed;

  @override
  ObservableList<Comment>? get comments => (_$commentsComputed ??=
          Computed<ObservableList<Comment>?>(() => super.comments,
              name: '_stepDetailsControllerBase.comments'))
      .value;
  Computed<int>? _$numCommentsComputed;

  @override
  int get numComments =>
      (_$numCommentsComputed ??= Computed<int>(() => super.numComments,
              name: '_stepDetailsControllerBase.numComments'))
          .value;

  final _$_stepAtom = Atom(name: '_stepDetailsControllerBase._step');

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

  final _$_numPlayedAtom = Atom(name: '_stepDetailsControllerBase._numPlayed');

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

  final _$_numLikedAtom = Atom(name: '_stepDetailsControllerBase._numLiked');

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

  final _$_favoriteStepAtom =
      Atom(name: '_stepDetailsControllerBase._favoriteStep');

  @override
  bool? get _favoriteStep {
    _$_favoriteStepAtom.reportRead();
    return super._favoriteStep;
  }

  @override
  set _favoriteStep(bool? value) {
    _$_favoriteStepAtom.reportWrite(value, super._favoriteStep, () {
      super._favoriteStep = value;
    });
  }

  final _$_busyAtom = Atom(name: '_stepDetailsControllerBase._busy');

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

  final _$deleteCommentAsyncAction =
      AsyncAction('_stepDetailsControllerBase.deleteComment');

  @override
  Future<dynamic> deleteComment(Comment comment) {
    return _$deleteCommentAsyncAction.run(() => super.deleteComment(comment));
  }

  final _$addCommentAsyncAction =
      AsyncAction('_stepDetailsControllerBase.addComment');

  @override
  Future<dynamic> addComment(String commentText) {
    return _$addCommentAsyncAction.run(() => super.addComment(commentText));
  }

  final _$_stepDetailsControllerBaseActionController =
      ActionController(name: '_stepDetailsControllerBase');

  @override
  void addNumPlayed() {
    final _$actionInfo = _$_stepDetailsControllerBaseActionController
        .startAction(name: '_stepDetailsControllerBase.addNumPlayed');
    try {
      return super.addNumPlayed();
    } finally {
      _$_stepDetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFavoriteStep() {
    final _$actionInfo = _$_stepDetailsControllerBaseActionController
        .startAction(name: '_stepDetailsControllerBase.changeFavoriteStep');
    try {
      return super.changeFavoriteStep();
    } finally {
      _$_stepDetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _updateNumLikedStep(bool? favoritado) {
    final _$actionInfo = _$_stepDetailsControllerBaseActionController
        .startAction(name: '_stepDetailsControllerBase._updateNumLikedStep');
    try {
      return super._updateNumLikedStep(favoritado);
    } finally {
      _$_stepDetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBusy(bool value) {
    final _$actionInfo = _$_stepDetailsControllerBaseActionController
        .startAction(name: '_stepDetailsControllerBase.setBusy');
    try {
      return super.setBusy(value);
    } finally {
      _$_stepDetailsControllerBaseActionController.endAction(_$actionInfo);
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
