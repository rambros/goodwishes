import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/app_controller.dart';
import '/app/modules/journey/model/step_model.dart';
import '/app/shared/utils/ui_utils.dart';

class DraftStepItem extends StatelessWidget {
  final StepModel? step;
  final Function? onDeleteItem;
  final Function? onPublishItem;
  final Function? onEditItem;
  final String? userRole;

  const DraftStepItem({
    Key? key,
    this.step,
    this.onDeleteItem,
    this.onPublishItem,
    this.onEditItem,
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
                            _getTitle(step!.title),
                            verticalSpace(4),
                            verticalSpace(2),
                            _getDescriptionText(step!.descriptionText),
                            verticalSpace(2),
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
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              Icons.public,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              if (onPublishItem != null) {
                                onPublishItem!();
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              if (onDeleteItem != null) {
                                onDeleteItem!();
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  : Material(), //Icon(Icons.favorite_border),
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
