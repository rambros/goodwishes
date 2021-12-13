// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canal_viver_search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CanalViverSearchController on _CanalViverSearchController, Store {
  final _$_channelAtom = Atom(name: '_CanalViverSearchController._channel');

  @override
  Channel? get _channel {
    _$_channelAtom.reportRead();
    return super._channel;
  }

  @override
  set _channel(Channel? value) {
    _$_channelAtom.reportWrite(value, super._channel, () {
      super._channel = value;
    });
  }

  final _$_isLoadingAtom = Atom(name: '_CanalViverSearchController._isLoading');

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

  final _$loadMoreVideosAsyncAction =
      AsyncAction('_CanalViverSearchController.loadMoreVideos');

  @override
  Future<dynamic> loadMoreVideos({String? channelId}) {
    return _$loadMoreVideosAsyncAction
        .run(() => super.loadMoreVideos(channelId: channelId));
  }

  final _$startSearchAsyncAction =
      AsyncAction('_CanalViverSearchController.startSearch');

  @override
  Future<dynamic> startSearch({String? channelId, String? query}) {
    return _$startSearchAsyncAction
        .run(() => super.startSearch(channelId: channelId, query: query));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
