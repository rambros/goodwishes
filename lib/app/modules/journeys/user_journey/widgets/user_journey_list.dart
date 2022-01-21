import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../user_journey.dart';

Widget UserJourneyList(UserJourneyListCubit cubit) {
  final userRole = cubit.getUserRole;
  return Observer(
    builder: (BuildContext context) {
      return Material(
          child: cubit.userJourneys != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cubit.userJourneys!.length,
                  padding:EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => cubit.showUserJourneyDetails(index),
                    child: UserJourneyItem(
                      userJourney: cubit.userJourneys![index],
                      onCancelItem: () => cubit.cancelUserJourney(index),
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