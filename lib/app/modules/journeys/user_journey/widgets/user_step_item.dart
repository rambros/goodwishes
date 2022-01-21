import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/app_controller.dart';
import '/app/modules/journeys/model/models.dart';
import '/app/shared/utils/ui_utils.dart';

class UserStepItem extends StatelessWidget {
  final UserStep? userStep;
  final Function? onChangeStatusItem;
  final Function? onEditItem;
  final Function? onPlayItem;
  final String? userRole;

  const UserStepItem({
    Key? key,
    this.userStep,
    this.onChangeStatusItem,
    this.onEditItem,
    this.onPlayItem,
    this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appSettings = Modular.get<AppController>();
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 6.0, top: 6.0),
      height: 95,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: _appSettings.isDarkTheme!
          ? [ BoxShadow(blurRadius: 8, color: Colors.grey[850]!, spreadRadius: 3) ]
          : [ BoxShadow(blurRadius: 8, color: Colors.grey[200]!, spreadRadius: 3) ],
          ),
      alignment: Alignment.center,
      child: Material(
        borderRadius: BorderRadius.circular(6.0),
        elevation: 2.0,
        child: Container(
          height: 100.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 2.0, top: 6.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _getTitle(userStep?.step.title),
                            verticalSpace(4),
                            _getDescriptionText(userStep?.step.descriptionText),
                            verticalSpace(4),
                            Text('Step -> ${userStep?.step.stepNumber}')
                          ]),
                    ),
                  ),
                ],
              )),
              (userRole == 'Admin')
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              if (onEditItem != null) {
                                onEditItem!();
                              }
                            },
                          ),
                        ),
                        // Expanded(
                        //   child: IconButton(
                        //     color: Theme.of(context).colorScheme.primary,
                        //     icon: Icon(
                        //       Icons.refresh,
                        //     ),
                        //     onPressed: () {
                        //       if (onChangeStatusItem != null) {
                        //         onChangeStatusItem!();
                        //       }
                        //     },
                        //   ),
                        // ),
                      ],
                    )
                  : Column(
                    children: [
                      Expanded(
                          child: IconButton(
                            padding: EdgeInsets.only(right: 32),
                            icon: Icon(
                              Icons.play_circle_outline,
                              color: Theme.of(context).colorScheme.primary,
                              size: 48,
                            ),
                            onPressed: () {
                              if (onPlayItem != null) {
                                onPlayItem!();
                              }
                            },
                          ),
                        ),
                    ],
                  ), //Icon(Icons.favorite_border),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _getTitle(title) {
  return Text(
    title,
    maxLines: 1,
    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
    //style: titlePostTextStyle,
  );
}

Widget _getDescriptionText(text) {
  return Container(
    //margin: EdgeInsets.only(top: 5.0),
    child: Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0),
    ),
  );
}
