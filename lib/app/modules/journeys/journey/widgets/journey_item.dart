import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/app/modules/journeys/model/models.dart';
import '/app/shared/utils/ui_utils.dart';

class JourneyItem extends StatelessWidget {
  final Journey? journey;
  final Function? onDeleteItem;
  final Function? onPublishItem;
  final Function? onEditItem;
  final String? userRole;

  const JourneyItem({
    Key? key,
    this.journey,
    this.onDeleteItem,
    this.onPublishItem,
    this.onEditItem,
    this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _appSettings = Modular.get<AppController>();
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 6.0, top: 6.0),
      height: 360,
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(6),
      //     boxShadow: _appSettings.isDarkTheme!
      //     ? [ BoxShadow(blurRadius: 8, color: Colors.grey[850]!, spreadRadius: 3) ]
      //     : [ BoxShadow(blurRadius: 8, color: Colors.grey[200]!, spreadRadius: 3) ],
      //     ),
      alignment: Alignment.center,
      child: Material(
        borderRadius: BorderRadius.circular(6.0),
        elevation: 2.0,
        child: Container(
          height: 360.0,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 6.0, top: 6.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            JourneyItemImageStack(journey: journey!),
                            verticalSpace(8),
                            _getTitle(journey!.title),
                            verticalSpace(8),
                            _getDescription(journey!.description),
                            verticalSpace(8),
                            statusLine(),
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

  Row statusLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Number of Steps: ${journey?.steps?.length}'),
        Text('Status: ${journey?.status}'),
      ],
    );
  }
}

class JourneyItemImageStack extends StatelessWidget {
  const JourneyItemImageStack({
    Key? key,
    required this.journey,
  }) : super(key: key);

  final Journey journey;

  @override
  Widget build(BuildContext context) {
    if (journey.imageFileName == null) {
        return Container();
    } else {
    return Container(
        height: MediaQuery.of(context).size.height * .32,
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
                  padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Know More',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSecondary
                    ),
                  ),
              ),
            ),
          ),
      ]),
    );
  } 
  }
}

Widget _getTitle(title) {
  return Text(
    title,
    maxLines: 1,
    style: TextStyle(
      fontWeight: FontWeight.w600, 
      fontSize: 16.0,
    ),
  );
}

Widget _getDescription(text) {
  return Container(
    //margin: EdgeInsets.only(top: 5.0),
    child: Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.normal, 
        fontSize: 14.0,
      ),
    ),
  );
}
