import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '/app/modules/video/model/channel_model.dart';
import '/app/modules/video/model/video_model.dart';
import '/app/modules/video/utils/keys.dart';

class YoutubeService {
  YoutubeService._instantiate();

  static final YoutubeService instance = YoutubeService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';
  int? _totalVideosPlayList = 0;
  var _channel = Channel();

  void initializeToken() {
    _nextPageToken = '';
   // _channel.videos = [];
   // return _channel;
  }

  String? get totalVideosSearch => _channel.videoCount;
  int? get totalVideosPlayList => _totalVideosPlayList;

  Future<Channel> fetchChannel({String? channelId, int? initialVideo}) async {
    if (initialVideo == 0) _nextPageToken = '';
    var  parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };
    var uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    var  headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      var channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  // initialize _channel to build profile card in UI
   Future<Channel> startChannel({String? channelId, int? initialVideo}) async {
    _totalVideosPlayList = 0;
    if (initialVideo == 0) _nextPageToken = '';
    var  parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };
    var uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    var  headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      var channel = Channel.fromMap(data);
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }


  Future<List<Video>> fetchVideosFromPlaylist({String? playlistId}) async {
    var parameters = {
      'part': 'snippet,contentDetails',
      'playlistId': playlistId,
      'maxResults': '45',
      'pageToken': _nextPageToken,
      'key': API_KEY,
    };
    var uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      _totalVideosPlayList = data['pageInfo']['totalResults'];
      List<dynamic> videosJson = data['items'];

      // Fetch first videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromSearch({String? channelId, String? query}) async {
    var  parameters = {
      'part': 'snippet',
      'channelId': channelId, 
      'maxResults': '45',
      'pageToken': _nextPageToken,
      'type': 'video',
      'q': query,
      'key': API_KEY,
    };
    var uri = Uri.https(
      _baseUrl,
      '/youtube/v3/search',
      parameters,
    );
    var  headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      _channel.videoCount = data['pageInfo']['totalResults'].toString();
      List<dynamic> videosJson = data['items'];

      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMapSearch(json),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

}