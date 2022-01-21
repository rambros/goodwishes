import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/app/modules/journeys/model/models.dart';
import '/app/shared/utils/ui_utils.dart';

class UserJourneyItem extends StatelessWidget {
  final UserJourney? userJourney;
  final Function? onCancelItem;
  final String? userRole;

  const UserJourneyItem({
    Key? key,
    this.userJourney,
    this.onCancelItem,
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
                            UserJourneyItemImageStack(userJourney: userJourney!),
                            verticalSpace(8),
                            _getTitle(userJourney!.title),
                            verticalSpace(8),
                            _getDescription(userJourney!.description),
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
                            color: Theme.of(context).colorScheme.primary,
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              if (onCancelItem != null) {
                                onCancelItem!();
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
        Text('Number of Steps: ${userJourney?.stepsTotal}'),
        Text('Status: ${userJourney?.status}'),
      ],
    );
  }
}

class UserJourneyItemImageStack extends StatelessWidget {
  const UserJourneyItemImageStack({
    Key? key,
    required this.userJourney,
  }) : super(key: key);

  final UserJourney userJourney;

  @override
  Widget build(BuildContext context) {
    if (userJourney.imageFileName == null) {
        return Container();
    } else {
    return Container(
        height: MediaQuery.of(context).size.height * .32,
        child: Stack(children: <Widget>[
          Hero(
            tag: userJourney.imageFileName!,
            child: userJourney.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.all(const Radius.circular(6.0)),
                    child: CachedNetworkImage(
                      imageUrl: userJourney.imageUrl!,
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
