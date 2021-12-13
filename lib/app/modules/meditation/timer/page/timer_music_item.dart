import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/widgets/get_image_url.dart';
import '/app/shared/utils/ui_utils.dart';

import '../controller/timer_controller.dart';
import '../model/timer_music_model.dart';

class TimerMusicItem extends StatefulWidget {
  final TimerMusic? timerMusic;
  final Function? onDeleteItem;
  final String? userRole;
  final bool? isSelectedItem;

  const TimerMusicItem({
    Key? key,
    this.timerMusic,
    this.onDeleteItem,
    this.userRole,
    this.isSelectedItem,
  }) : super(key: key);

  @override
  _TimerMusicItemState createState() => _TimerMusicItemState();
}

class _TimerMusicItemState extends ModularState<TimerMusicItem, TimerController> {
  @override
  Widget build(BuildContext context) {
    //selectedMusic
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8.0, top: 8.0),
      padding: EdgeInsets.only(
        right: 10,
      ),
      height: widget.timerMusic!.imageUrl != null ? null : 64,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Theme.of(context).accentColor,
            width: 1.0,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(6),
        // boxShadow: _appSettings.isDarkTheme
        // ? [ BoxShadow(blurRadius: 8, color: Colors.grey[850], spreadRadius: 3) ]
        // : [ BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3) ],
      ),
      alignment: Alignment.center,
      child: Material(
        borderRadius: BorderRadius.circular(6.0),
        elevation: 0.0,
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Hero(
                    tag: widget.timerMusic!.imageFileName!,
                    child: widget.timerMusic!.imageUrl != null
                        ? GetImageUrl(
                            imageUrl: widget.timerMusic!.imageUrl,
                            width: 60.0,
                            height: 60.0)
                        : Container(),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 2.0, top: 6.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            verticalSpace(12),
                            _getTitle(widget.timerMusic!.title),
                          ]),
                    ),
                  ),
                ],
              )),
              Observer(
                builder: (BuildContext context) {
                  return widget.isSelectedItem!
                      ? Icon(
                          Icons.play_circle_filled,
                          color: Theme.of(context).accentColor,
                          size: 30,
                        )
                      : Icon(
                          Icons.play_circle_outline,
                          color: Theme.of(context).accentColor,
                          size: 30,
                        );
                },
              ),

              (widget.userRole != 'Admin')
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                            color: Theme.of(context).accentColor,
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              if (widget.onDeleteItem != null) {
                                widget.onDeleteItem!();
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
    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
    //style: titlePostTextStyle,
  );
}
