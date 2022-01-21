import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:goodwishes/app/modules/journeys/audio_player/audio_player_page.dart';
import 'package:goodwishes/app/modules/journeys/helper/helper.dart';

import '../controller/user_step_details_controller.dart';
import '/app/modules/journeys/audio_player/player_model.dart';
import '/app/shared/utils/ui_utils.dart';

class UserStepDetailsPage extends StatefulWidget {
  final UserJourneyStepArgs args;
  const UserStepDetailsPage({Key? key, required this.args}) : super(key: key);

  @override
  _UserStepDetailsPageState createState() => _UserStepDetailsPageState();
}

class _UserStepDetailsPageState
    extends ModularState<UserStepDetailsPage, UserStepDetailsController> {

  @override
  void initState() {
    controller.init(widget.args.userStep!);
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
                TitleField(title: widget.args.userStep?.step.title),
                verticalSpace(16),
                DescriptionField(description: widget.args.userStep?.step.descriptionText),
                verticalSpace(24),
                //PlayWidget(widget: widget, controller: controller, ),
                MyInsightDetails(widget: widget, controller: controller,),
                verticalSpace(16),
                MyMeditationDetails(widget: widget, controller: controller,),
                verticalSpace(16),
                MyPracticeDetails(widget: widget),
                verticalSpace(32),
              ],
            ),
          ),
        ));
  }
}


class MyInsightDetails extends StatelessWidget {
  const MyInsightDetails({Key? key,required this.widget, required this.controller}) : super(key: key);

  final UserStepDetailsPage widget;
  final UserStepDetailsController controller;

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
                id: widget.args.userStep?.step.documentId,
                urlAudio: widget.args.userStep?.step.inspirationAudioURL,
                title: widget.args.userStep?.step.title,
                duration: widget.args.userStep?.step.inspirationDuration,
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



class MyPracticeDetails extends StatelessWidget {
  const MyPracticeDetails({Key? key,required this.widget,}) : super(key: key);

  final UserStepDetailsPage widget;

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




class MyMeditationDetails extends StatelessWidget {
  const MyMeditationDetails({Key? key,required this.widget, required this.controller}) : super(key: key);

  final UserStepDetailsPage widget;
  final UserStepDetailsController controller;

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
                id: widget.args.userStep?.step.documentId,
                urlAudio: widget.args.userStep?.step.meditationAudioURL,
                title: widget.args.userStep?.step.title,
                duration: widget.args.userStep?.step.meditationDuration,
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
  const TitleField({Key? key,required this.title,}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title!,
          textAlign: TextAlign.center,
          style:TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),

    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({Key? key,required this.description,}) : super(key: key);

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          description!,
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

  final UserStepDetailsPage widget;
  final UserStepDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .42,
      //height: 300,
      child: Stack(children: <Widget>[
        widget.args.userStep?.step.inspirationAudioURL != null
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
                            // var model = PlayerModel(
                            //   id: widget.args.step!.documentId,
                            //   urlAudio: widget.args.step!.inspirationAudioURL,
                            //   title: widget.args.step!.title,
                            //   duration: widget.args.step!.inspirationDuration,
                            // );
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
