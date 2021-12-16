import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/journey/model/step_model.dart';
import '../controller/draft_step_details_controller.dart';
import '/app/modules/journey/audio_player/player_model.dart';
import '/app/shared/comment/comment.dart';
import '/app/shared/utils/date_util.dart';
import '/app/shared/utils/ui_utils.dart';

class DraftStepDetailsPage extends StatefulWidget {
  final StepModel? step;
  const DraftStepDetailsPage({Key? key, this.step}) : super(key: key);

  @override
  _DraftStepDetailsPageState createState() => _DraftStepDetailsPageState();
}

class _DraftStepDetailsPageState
    extends ModularState<DraftStepDetailsPage, DraftStepDetailsController> {

  @override
  void initState() {
    controller.init(widget.step!);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Step activities - Draft Mode'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(24),
                Center(
                  child: Text(widget.step!.title!,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                ),
                verticalSpace(16),
                Observer(
                  builder: (BuildContext context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${widget.step!.inspirationDuration}',
                            style:
                                TextStyle(fontSize: 14.0, 
                                //color: Colors.black,
                                )),
                        Text('${controller.numPlayed} reproduções',
                            style:
                                TextStyle(fontSize: 14.0, 
                                //color: Colors.black,
                                )),
                        Container(
                            child: Row(
                          children: <Widget>[
                            Text(
                              '${controller.numLiked} ',
                              style: TextStyle(
                                  fontSize: 14.0, 
                                  //color: Colors.black,
                                  ),
                            ),
                            Icon(
                              Icons.favorite,
                              size: 14,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        )),
                      ],
                    );
                  },
                ),
                verticalSpace(16),
                Container(
                  height: MediaQuery.of(context).size.height * .42,
                  //height: 300,
                  child: Stack(children: <Widget>[
                    widget.step!.inspirationAudioURL != null
                        ? Center(
                            child: Opacity(
                              opacity: 0.7,
                              child: Container(
                                  //padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(Icons.play_circle_outline),
                                      iconSize: 84.0,
                                      color: Colors.white,
                                      onPressed: () {
                                        //controller.addNumPlayed();
                                        var model = PlayerModel(
                                          id: widget.step!.documentId,
                                          urlAudio: widget.step!.inspirationAudioURL,
                                          title: widget.step!.title,
                                          duration: widget.step!.inspirationDuration,
                                        );
                                        Modular.to.pushNamed(
                                            '/journey/audio_player',
                                            arguments: model);
                                      })),
                            ),
                          )
                        : Container(),
                  ]),
                ),
                verticalSpaceSmall,
                Center(
                  child: Text(
                    widget.step!.descriptionText!,
                    style: TextStyle(fontSize: 14.0, 
                    //color: Colors.black,
                    ),
                  ),
                ),
                verticalSpaceSmall,
                verticalSpace(8),
                Observer(
                  builder: (BuildContext context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.comment),
                          iconSize: 36.0,
                          //color: Colors.black,
                          onPressed: () {
                           // _showCommentDialog();
                          },
                        ),
                        Text(controller.numComments.toString()),
                        SizedBox(
                          width: 64,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                //controller.changeFavoriteMeditation();
                              },
                              child: controller.favoriteMeditation!
                                  ? Icon(Icons.favorite, size: 36.0)
                                  : Icon(Icons.favorite_border, size: 36.0),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                Divider(thickness: 1.0, indent: 16.0, endIndent: 16.0),
                Observer(builder: (BuildContext context) {
                  return Material(
                      child: controller.numComments > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.numComments,
                              padding: EdgeInsets.only(top: 5.0, left: 5.0),
                              itemBuilder: (context, index) =>
                                  showComment(controller.orderComments![index]),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Text('Be the first to comment...'),
                              ),
                            ));
                })
              ],
            ),
          ),
        ));
  }

  Widget showComment(Comment comment) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0.0, top: 10.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              //padding: EdgeInsets.fromLTRB(4, 0, 2, 0),
              child: comment.userImageUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(comment.userImageUrl!),
                    )
                  : Icon(Icons.person_pin, size: 48.0),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(8, 0, 2, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      comment.userName ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16.0),
                    ),
                    SizedBox(height: 4),
                    Text(
                      DateUtil().buildDate(comment.commentDate!),
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 12.0),
                    ),
                    SizedBox(height: 6),
                    Text(
                      comment.comment!,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   //padding: EdgeInsets.fromLTRB(4, 0, 2, 0),
            //   child: (controller.canDeleteComment(comment))
            //       ? IconButton(
            //           icon: Icon(
            //             Icons.delete,
            //             color: Theme.of(context).accentColor,
            //           ),
            //           onPressed: () {
            //             controller.deleteComment(comment);
            //           },
            //         )
            //       : Icon(Icons.person_pin, size: 48.0),
            // ),
          ],
        ),
      ),
    );
  }

}
