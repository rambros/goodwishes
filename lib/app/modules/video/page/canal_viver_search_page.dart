import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/video/controller/canal_viver_search_controller.dart';
import '/app/modules/video/model/video_model.dart';
import '/app/modules/video/utils/keys.dart';
import '/app/shared/utils/ui_utils.dart';

import 'canal_viver_player_page.dart';


class CanalViverSearchPage extends StatefulWidget {
  @override
  _CanalViverSearchPageState createState() => _CanalViverSearchPageState();
}

class _CanalViverSearchPageState
    extends ModularState<CanalViverSearchPage, CanalViverSearchController> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //controller.initChannel();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.selection =
            TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      }
    });
  }

  Widget _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CanalViverPlayerPage(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
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
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar videos no canal',
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              onSubmitted: (searchQuery) {
                controller.startSearch(
                    channelId: kChannelIdViver, query: searchQuery);
              },
              controller: _controller,
              focusNode: _focusNode,
            ),
            //SearchField(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Observer(
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  verticalSpace(15),
                  controller.isReady
                      ? Text(
                          'Resultado da Pesquisa - ${controller.channel!.videos!.length} videos')
                      : Text('Digite o texto para pesquisar'),
                  verticalSpace(10),
                  Material(
                    child: controller.isReady
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.channel!.videos!.length,
                            padding: EdgeInsets.only(
                                top: 8.0, left: 8.0, bottom: 4.0),
                            itemBuilder: (BuildContext context, int index) {
                              var video = controller.channel!.videos![index];
                              return _buildVideo(video);
                            },
                          )
                        : controller.isLoading
                            ? Container(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context).primaryColor),
                                  ),
                                ),
                              )
                            : Container(),
                  ),
                ],
              );
            },
          ),
        ),
      ),

      //  controller.channel != null
      // ? NotificationListener<ScrollNotification>(
      //     onNotification: (ScrollNotification scrollDetails) {
      //       if (!controller.isLoading &&
      //           controller.channel.videos.length != int.parse(controller.channel.videoCount) &&
      //           scrollDetails.metrics.pixels ==
      //               scrollDetails.metrics.maxScrollExtent) {
      //         controller.loadMoreVideos(channelId: kChannelIdViver);
      //       }
      //       return false;
      //     },
      //     child: ListView.builder(
      //       itemCount: controller.channel.videos.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         Video video = controller.channel.videos[index];
      //         return _buildVideo(video);
      //       },
      //     ),
      //   )
      // : controller.isSearching
      //     ? Center(
      //         child: CircularProgressIndicator(
      //             valueColor: AlwaysStoppedAnimation<Color>(
      //                 Theme.of(context).primaryColor, // Red
      //                 ),
      //         ),
      //      )
      //   : Container(),
    );
  }
}
