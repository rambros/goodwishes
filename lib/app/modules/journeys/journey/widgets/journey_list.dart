import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../journey.dart';

Widget JourneyList(JourneyListController controller) {
  final userRole = controller.getUserRole;
  return Observer(
    builder: (BuildContext context) {
      return Material(
          child: controller.journeys != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.journeys!.length,
                  padding:EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => controller.showJourneyDetails(index),
                    child: JourneyItem(
                      journey: controller.journeys![index],
                      onDeleteItem: () => controller.deleteJourney(index),
                      onPublishItem: () {},
                      onEditItem: () => controller.editJourney(index),
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