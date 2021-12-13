import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:share/share.dart';

import '/app/modules/agenda/controller/event_details_controller.dart';
import '/app/modules/agenda/model/event_model.dart';
import '/app/shared/utils/ui_utils.dart';

class EventDetailsPage extends StatefulWidget {
  final EventModel? event;
  const EventDetailsPage({Key? key, this.event}) : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends ModularState<EventDetailsPage, EventDetailsController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Evento'),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 28.0),
            icon: Icon(Icons.share, size: 32.0 ),
            onPressed: () {
              var msgToShare =
      '''Olá, quero convidar você para assistir este programa:\n*${widget.event!.name}*\n${widget.event!.descriptionText}\n\nhttps://brahmakumaris.org.br/programacao/calendario''';                      
              final RenderBox box = context.findRenderObject() as RenderBox;
              Share.share(msgToShare,
                  subject: 'App MeditaBK',
                  sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
            },
          ),
        ],
      ),
      
      // floatingActionButton: widget.event.requiresRegistration == true
      //     ? FloatingActionButton(
      //             backgroundColor: Theme.of(context).accentColor,
      //             //child: Text('Fazer inscrição'),
      //             child: Icon(Icons.event_available, size: 36),
      //             onPressed: () {
      //              controller.launchURL(widget.event.eventDateId);
      //              //Modular.to.pushNamed('/agenda/event/registration');
      //             })
      //     : Container(),

      body: 
        // SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 24.0),
        //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        //       verticalSpace(24),
        //       Center(
        //         child: Text(widget.event.name,
        //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        //       ),
        //       verticalSpace(12),
        //       Center(
        //         child: Text(widget.event.descriptionText,
        //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
        //       ),
        //     ]),
        //   ),
        // ),

        // Stack(
        //   children: <Widget>[
        //     Positioned(
        //       child: Container(
        //         padding: EdgeInsets.all(8),
        //         child: EasyWebView(
        //           src: '$centerStyle <h2>${widget.event.name}</h2>' + widget.event.description,
        //           isHtml: true, // Use Html syntax
        //           isMarkdown: false,
        //           onLoaded: () {}, // Use markdown syntax
        //           //convertToWidegts: false, // Try to convert to flutter widgets
        //           width: MediaQuery.of(context).size.width * 1.0,
        //           //height: MediaQuery.of(context).size.height * 1.80,
        //         ),
        //       ),
        //     ),
        //     ],
        // ),

           SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      HtmlWidget(
                        '<center> <h3>${widget.event!.name}</h3></center>' + widget.event!.description!,
                        onTapUrl: (url) async => controller.launchLink(url),
                      ),
                      verticalSpace(24),
                      widget.event!.requiresRegistration == true 
                      ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).colorScheme.secondary, // background
                                onPrimary: Colors.white,
                                elevation: 3, // foreground
                            ),
                            //color: Theme.of(context).accentColor,
                            //textColor: Colors.white,
                            //elevation: 3,
                            child: Text(
                                'Fazer inscrição'.toUpperCase(),
                                 style: TextStyle(fontSize: 18 ),
                            ),
                            onPressed: () {
                              controller.launchURL(widget.event!.eventDateId);
                            },
                        )
                      : Container(),
                    ],
                  ),
                ),
           ),
    );
  }


}
