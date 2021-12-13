import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/app/shared/user/user_app_model.dart';
import '/app/shared/utils/ui_utils.dart';

const String dob = "dob";

class AuthorDetailsPage extends StatefulWidget {
  final UserApp? author;
  const AuthorDetailsPage({Key? key, this.author}) : super(key: key);
  @override
  _AuthorDetailsPageState createState() => _AuthorDetailsPageState();
}

class _AuthorDetailsPageState extends State<AuthorDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sobre ${widget.author!.fullName}'),
        ),
        body: ListView(children: <Widget>[
          Stack(children: <Widget>[
            // The containers in the background
            Column(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .38,
                color: Theme.of(context).colorScheme.secondary,
                // decoration: BoxDecoration(
                //   // Box decoration takes a gradient
                //   gradient: LinearGradient(
                //     // Where the linear gradient begins and ends
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     // Add one stop for each color. Stops should increase from 0 to 1
                //     stops: [0.1, 0.5, 0.7, 0.9],
                //     colors: [
                //       Colors.red[300],
                //       Colors.red[300],
                //       Colors.deepOrange[300],
                //       Colors.deepOrange[200],
                //     ],
                //   ),
                // ),
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Column(
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Hero(
                        tag: widget.author!.email!,
                        child: Container(
                          //width: 150,
                          //height: 150,
                          child: widget.author!.userImageUrl != null
                              ? CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage:
                                      NetworkImage(widget.author!.userImageUrl!),
                                  //backgroundColor: Colors.white,
                                )
                              : Container(
                                  child: Icon(Icons.perm_identity,
                                      size: 120.0, color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(widget.author!.fullName!,
                          style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
                          ),
                    ),
                  ],
                ),
              ),
            ]),
            Column(
              children: <Widget>[
                verticalSpace(MediaQuery.of(context).size.height * .10),
                 Container(
                    padding:  EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .18,
                        right: 20.0,
                        left: 20.0),
                    child:  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.white,
                        elevation: 4.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[],
                        ),
                      ),
                    )),
                 Container(
                    padding:
                         EdgeInsets.only(top: 20, right: 8.0, left: 8.0),
                    child:  Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                            //color: Colors.white,
                            elevation: 4.0,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 16, 16),
                                      child: Text(
                                        widget.author!.curriculum ??
                                            'Em breve',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 16,
                                      ),
                                    )),
                                  ],
                                ),
                                Row(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 8, 16, 16),
                                    child: Text(
                                      "${widget.author!.contact ?? ' '}",
                                    ),
                                  )
                                ]),
                                // Row(
                                //   children: <Widget>[
                                //     widget.author.site != null
                                //         ? Padding(
                                //             padding: const EdgeInsets.fromLTRB(
                                //                 16, 8, 16, 16),
                                //             child: Text(
                                //                 '${widget.author.site}'),
                                //           )
                                //         : Container(),
                                //   ],
                                // ),
                                // verticalSpace(16)
                              ],
                            )))),
              ],
            ),

          ])
        ]));
  }
}
