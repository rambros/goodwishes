import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:goodwishes/app/modules/journey/audio_player/audio_player_page.dart';

import '../controller/step_details_controller.dart';
import '/app/modules/journey/model/step_model.dart';
import '/app/modules/journey/audio_player/player_model.dart';
import '/app/shared/comment/comment.dart';
import '/app/shared/utils/date_util.dart';
import '/app/shared/utils/ui_utils.dart';

class StepDetailsPage extends StatefulWidget {
  final StepModel? step;
  const StepDetailsPage({Key? key, this.step}) : super(key: key);

  @override
  _StepDetailsPageState createState() => _StepDetailsPageState();
}

class _StepDetailsPageState
    extends ModularState<StepDetailsPage, StepDetailsController> {

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
          title: const Text('Activities of this step'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12,8,12,8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(24),
                TitleField(widget: widget),
                verticalSpace(16),
                DescriptionField(widget: widget),
                verticalSpace(24),
                //PlayWidget(widget: widget, controller: controller, ),
                InsightDetails(widget: widget, controller: controller,),
                verticalSpace(16),
                MeditationDetails(widget: widget, controller: controller,),
                verticalSpace(16),
                PracticeDetails(widget: widget),
                verticalSpace(32),
                //showNumberCommentsLikes(),
                Divider(thickness: 1.0, indent: 16.0, endIndent: 16.0),
                showCommentsArea()
              ],
            ),
          ),
        ));
  }

  Observer showCommentsArea() {
    return Observer(builder: (BuildContext context) {
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
    });
  }

  Observer showNumberCommentsLikes() {
    return Observer(
      builder: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.comment),
              iconSize: 36.0,
              onPressed: () => _showCommentDialog(),
            ),
            Text(controller.numComments.toString()),
            SizedBox(width: 64,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => controller.changeFavoriteStep(),
                  child: controller.favoriteStep!
                      ? Icon(Icons.favorite, size: 36.0)
                      : Icon(Icons.favorite_border, size: 36.0),
                ),
              ],
            ),
          ],
        );
      },
    );
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
            Container(
              child: (controller.canDeleteComment(comment))
                  ? IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () => controller.deleteComment(comment),
                    )
                  : Icon(Icons.person_pin, size: 48.0),
            ),
          ],
        ),
      ),
    );
  }

  void _showCommentDialog() {
    var _hasInputError = false;
    var comment = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AlertDialog(
            title: Text('Comments'),
            content: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: comment,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText:
                            'Like this Step? \nLeave your comment here...',
                        errorText: _hasInputError
                            ? 'Required Field'
                            : null,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      onChanged: (value) {
                        _hasInputError = value.length < 2;
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            )),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  if (comment.text != '') {
                    controller.addComment(comment.text);
                    //print(comment.text);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('SUBMIT'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class InsightDetails extends StatelessWidget {
  const InsightDetails({Key? key,required this.widget, required this.controller}) : super(key: key);

  final StepDetailsPage widget;
  final StepDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NumberCircularWidget('1'),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Insights',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Hello World',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),

          IconButton(
            padding: EdgeInsets.only(right: 0),
            icon: Icon(
              Icons.play_circle_outline,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
            onPressed: () {
              var model = PlayerModel(
                id: widget.step!.documentId,
                urlAudio: widget.step!.inspirationAudioURL,
                title: widget.step!.title,
                duration: widget.step!.inspirationDuration,
              );
              var playlist = controller.playlistStep;
              var args = ArgsPlayer( model: model, playlist: playlist);
              Modular.to.pushNamed(
                  '/journey/audio_player',
                  arguments: args);
            },
          ),
          IconButton(   
            padding: EdgeInsets.only(right: 0),
            icon: Icon(
              Icons.text_snippet,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
    )
    );
  }
}



class PracticeDetails extends StatelessWidget {
  const PracticeDetails({Key? key,required this.widget,}) : super(key: key);

  final StepDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NumberCircularWidget2('3'),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Practice',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Simple steps to improve your experience',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          IconButton(   
            padding: EdgeInsets.only(right: 0),
            icon: Icon(
              Icons.text_snippet,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
    )
    );
  }
}




class MeditationDetails extends StatelessWidget {
  const MeditationDetails({Key? key,required this.widget, required this.controller}) : super(key: key);

  final StepDetailsPage widget;
  final StepDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NumberCircularWidget2('2'),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Guided Meditation',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Experience the power of goodwishes',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          
          IconButton(
            padding: EdgeInsets.only(right: 0),
            icon: Icon(
              Icons.play_circle_outline,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
            onPressed: () {
              var model = PlayerModel(
                id: widget.step!.documentId,
                urlAudio: widget.step!.meditationAudioURL,
                title: widget.step!.title,
                duration: widget.step!.meditationDuration,
              );
              var playlist = controller.playlistStep;
              var args = ArgsPlayer( model: model, playlist: playlist);
              Modular.to.pushNamed(
                  '/journey/audio_player',
                  arguments: args);
            },
          ),
          IconButton(   
            padding: EdgeInsets.only(right: 0),
            icon: Icon(
              Icons.text_snippet,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
    )
    );
  }
}

class NumberCircularWidget extends StatelessWidget {
  final String stepNumber;

  const NumberCircularWidget(this.stepNumber);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          height: 50,
          child: Container(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: Colors.black38,
                            offset: Offset(2, 2),
                          )
                        ],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF592828),
                        ),
                      ),
                      //alignment: Alignment(0.0, 0.0),
                      child:  Center(
                        child: Text(
                            stepNumber,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 30, 
                              fontWeight: FontWeight.w600),
                          ),
                      ),
                      ),
                    //),
                ],
              ),
            )
      ),
    );
  }
}



class NumberCircularWidget2 extends StatelessWidget {
  final String stepNumber;

  const NumberCircularWidget2(this.stepNumber);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          height: 50,
          child: Container(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: Colors.black38,
                            offset: Offset(2, 2),
                          )
                        ],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF592828),
                        ),
                      ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Center(
                      child: Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(
                            stepNumber,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 30, 
                              fontWeight: FontWeight.w600),
                          ),
                      ),
                    ),
                      ),
                ],
                      ),
                    //),
              ),
            )
      );
  }
}

class TitleField extends StatelessWidget {
  const TitleField({Key? key,required this.widget,}) : super(key: key);

  final StepDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.step!.title!,
          textAlign: TextAlign.center,
          style:TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),

    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({Key? key,required this.widget,}) : super(key: key);

  final StepDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          widget.step!.descriptionText!,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, 
          ),
        ),
      ),
    );
  }
}

class PlayWidget extends StatelessWidget {
  const PlayWidget({
    Key? key,
    required this.widget,
    required this.controller,
  }) : super(key: key);

  final StepDetailsPage widget;
  final StepDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        //borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.play_circle_outline),
                          iconSize: 84.0,
                          color: Colors.white,
                          //color: Theme.of(context).accentColor,
                          onPressed: () {
                            controller.addNumPlayed();
                            var model = PlayerModel(
                              id: widget.step!.documentId,
                              urlAudio: widget.step!.inspirationAudioURL,
                              title: widget.step!.title,
                              duration: widget.step!.inspirationDuration,
                            );
                            //Modular.to.pushNamed('/journey/audio_player',arguments: model);
                            Modular.to.pushNamed('/journey/audio_player',
                                  arguments: controller.playlistStep);
                          })),
                ),
              )
            : Container(),
      ]),
    );
  }
}
