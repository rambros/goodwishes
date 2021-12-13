import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/app_controller.dart';
import '/app/modules/meditation/guided/model/meditation.dart';
import '/app/shared/widgets/get_image_url.dart';
import '/app/shared/utils/ui_utils.dart';

class DraftMeditationItem extends StatelessWidget {
  final Meditation? meditation;
  final Function? onDeleteItem;
  final Function? onPublishItem;
  final Function? onEditItem;
  final String? userRole;

  const DraftMeditationItem({
    Key? key,
    this.meditation,
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
      height: meditation!.imageUrl != null ? null : 95,
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
                  Hero(
                    tag: meditation!.imageFileName!,
                    child: meditation!.imageUrl != null
                        ? GetImageUrl(
                            imageUrl: meditation!.imageUrl, width: 100.0, height: 100.0)
                        : Container(),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 2.0, top: 6.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _getTitle(meditation!.title),
                            verticalSpace(4),
                            _getAuthor(meditation!.authorName),
                            verticalSpace(2),
                            _getCallText(meditation!.callText),
                            verticalSpace(2),
                            _getStatistics(meditation!, Theme.of(context).accentColor),
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
                              color: Theme.of(context).accentColor,
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
                              color: Theme.of(context).accentColor,
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
                            color: Theme.of(context).accentColor,
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

Widget _getAuthor(author) {
  return Text(
    author,
    style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w500 ),
  );
}

Widget _getStatistics( Meditation meditation, Color cor) {
  String _duration = meditation.audioDuration!.substring(0,2); 
  return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '${_duration}min',
          style: TextStyle(fontSize: 12.0, ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                '${meditation.numPlayed} reproduções',
                style: TextStyle(fontSize: 12.0, ),
              ),
            // Icon(
            //   Icons.play_circle_filled,
            //   size: 16,
            // ),
            ],
          ),
        ),
        Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${meditation.numLiked} ',
              style: TextStyle(fontSize: 12.0, ),
            ),
            Icon(
              Icons.favorite,
              size: 16,
              color: cor,
            ),
          ],
        ))
      ],
    ); 
}

Widget _getCallText(text) {
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
