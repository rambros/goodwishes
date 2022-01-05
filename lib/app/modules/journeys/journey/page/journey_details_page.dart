import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../controller/journey_details_controller.dart';
import '/app/modules/journeys/step/page/step_item.dart';
import '/app/modules/journeys/model/models.dart';
import '/app/shared/utils/ui_utils.dart';

class JourneyDetailsPage extends StatefulWidget {
  final Journey? journey;
  const JourneyDetailsPage({Key? key, this.journey}) : super(key: key);

  @override
  _JourneyDetailsPageState createState() => _JourneyDetailsPageState();
}

class _JourneyDetailsPageState
    extends ModularState<JourneyDetailsPage, JourneyDetailsController> {

  @override
  void initState() {
    controller.init(widget.journey!);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRole = controller.getUserRole;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Journey Details and Steps'),
        ),
        floatingActionButton: (userRole == 'Admin')
          ? FloatingActionButton.extended(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: !controller.busy
                  ? Icon(Icons.add)
                  : CircularProgressIndicator(),
              label: Text('Start Journey'),
              onPressed: () {
                controller.addStep();
              })
          : null,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12,8,12,8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ImageStack(journey: widget.journey!),
                verticalSpace(8),
                TitleField(widget: widget),
                verticalSpace(8),
                DescriptionField(widget: widget),
                verticalSpace(8),
                //Text('Steps List'),
                //verticalSpace(8),
                StepsList(controller),
              ],
            ),
          ),
        ));
  }
}

class TitleField extends StatelessWidget {
  const TitleField({Key? key,required this.widget,}) : super(key: key);

  final JourneyDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.journey!.title!,
          textAlign: TextAlign.center,
          style:TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),

    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({Key? key,required this.widget,}) : super(key: key);

  final JourneyDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          widget.journey!.description!,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, 
          ),
        ),
      ),
    );
  }
}

Widget StepsList(JourneyDetailsController controller) {
  final userRole = controller.getUserRole;
  return Observer(
    builder: (BuildContext context) {
      return Container(
          child: controller.steps.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.steps.length,
                  padding:EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => controller.showStepDetails(index),
                    child: StepItem(
                      step: controller.steps[index],
                      onDeleteItem: () => controller.deleteStep(controller.steps[index]),
                      onEditItem: () => controller.editStep(index),
                      onPlayItem: () => controller.showStepDetails(index),
                      userRole: userRole,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor),
                    ),
                  ),
                ));
    },
  );
}

class ImageStack extends StatelessWidget {
  const ImageStack({
    Key? key,
    required this.journey,
  }) : super(key: key);

  final Journey journey;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .42,
        child: Stack(children: <Widget>[
          Hero(
            tag: journey.imageFileName!,
            child: journey.imageUrl != null
                ? ClipRRect(
                    borderRadius:
                        BorderRadius.all(const Radius.circular(6.0)),
                    child: CachedNetworkImage(
                      imageUrl: journey.imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                  )
                : Container(),
          ),
          Center(
            child: Opacity(
              opacity: 0.7,
              child: Container(
                  //padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(100),
                  ),
                  child: 
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        primary: Theme.of(context).colorScheme.secondary,// background
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      onPressed: () {
                        //_requestReview();
                      }, 
                      child: Text(
                          'Start Journey'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSecondary
                          ),
                        ),
                    ),
              ),
            ),
          )
      ]),
    );
  }
}