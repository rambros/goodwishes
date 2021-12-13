import 'package:flutter/material.dart';
import '/app/modules/video/model/channel_model.dart';
import '/app/modules/video/model/video_model.dart';
import '/app/modules/video/utils/keys.dart';
import '/app/shared/services/youtube_service.dart';

import 'entrevista_player_page.dart';


class EntrevistasListPage extends StatefulWidget {
  @override
  _EntrevistasListPageState createState() => _EntrevistasListPageState();
}

class _EntrevistasListPageState extends State<EntrevistasListPage> {
  Channel? _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  void _initChannel() async {
    _isLoading = true;
    var channel = await YoutubeService.instance
        .startChannel(channelId: kChannelIdBK, initialVideo: 0);
    _channel = channel;
    _channel!.videos = [];
    _loadMoreVideos();    
    setState(() {
      _channel = channel;
    });
    _isLoading = false;
  }

  Widget _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 110.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel!.profilePictureUrl!),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel!.title!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel!.subscriberCount} assinantes',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${YoutubeService.instance.totalVideosPlayList} vídeos',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EntrevistaPlayerPage(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl!),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadMoreVideos() async {
    _isLoading = true;
    var moreVideos = await YoutubeService.instance
        .fetchVideosFromPlaylist(playlistId: kPlayListIdEntrevista);
    var allVideos = _channel!.videos?..addAll(moreVideos);
    setState(() {
      _channel!.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrevistas'),
        // leading: IconButton(
        //     padding: EdgeInsets.only(left: 2.0),
        //     icon: Icon(Icons.home, size: 26.0 ),
        //     onPressed: () {
        //       Modular.to.pushReplacementNamed('/');
        //     },
        //   ),
        // actions: <Widget>[
        //   IconButton(
        //     padding: EdgeInsets.only(right: 28.0),
        //     icon: Icon(Icons.search, size: 32.0 ),
        //     onPressed: () {
        //       Modular.to.pushNamed('/video/canalviver/search');
        //     },
        //   ),
        // ]
      ),
      body: _channel != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel!.videos!.length != YoutubeService.instance.totalVideosPlayList &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 1 + _channel!.videos!.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildProfileInfo();
                  }
                  var video = _channel!.videos![index - 1];
                  return _buildVideo(video);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}