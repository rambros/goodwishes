import 'package:mobx/mobx.dart';

import '/app/shared/services/youtube_service.dart';
import '../model/channel_model.dart';
import '../utils/keys.dart';

part 'canal_viver_search_controller.g.dart';

class CanalViverSearchController = _CanalViverSearchController
    with _$CanalViverSearchController;

abstract class _CanalViverSearchController with Store {

  @observable
  Channel? _channel;

  Channel? get channel => _channel;

  @observable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _query;
  bool _isReady = false;
  bool get isReady => _isReady;

  void initChannel() async {
    final channel = await YoutubeService.instance
        .fetchChannel(channelId: kChannelIdViver, initialVideo: 0);
    _channel = channel;
  }

  @action
   Future loadMoreVideos({String? channelId}) async {
    _isLoading = true;
    var moreVideos = await YoutubeService.instance
        .fetchVideosFromSearch(channelId: channelId, query: _query);
    var allVideos = _channel!.videos?..addAll(moreVideos);
    _channel!.videos = allVideos;
    _isLoading = false;
  }

  @action
   Future startSearch({String? channelId, String? query}) async {
    _isLoading = true;
    _isReady = false;
    _query = query;
    YoutubeService.instance.initializeToken();
    _channel = Channel();
    _channel!.videos = [];
    var moreVideos = await YoutubeService.instance
        .fetchVideosFromSearch(channelId: channelId, query: query);
    var allVideos = _channel!.videos?..addAll(moreVideos);

    _channel!.videos = allVideos;
    _channel!.videoCount = YoutubeService.instance.totalVideosSearch;
    _isLoading = false;
    _isReady = true;
  }
}
