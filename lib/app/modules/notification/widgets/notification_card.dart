import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_controller.dart';
import '../../../shared/utils/next_screen.dart';
import '../models/notification_model.dart';
import '../pages/notification_details_page.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel d;
  const NotificationCard({Key? key, required this.d})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appSettings = Modular.get<AppController>();
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: _appSettings.isDarkTheme! 
          ? Colors.black
          : Colors.white, 
          borderRadius: BorderRadius.circular(6),
          boxShadow: _appSettings.isDarkTheme!
          ? [ BoxShadow(blurRadius: 8, color: Colors.grey[850]!, spreadRadius: 3) ]
          : [ BoxShadow(blurRadius: 8, color: Colors.grey[200]!, spreadRadius: 3) ],
          ),
          child: Container(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[500]!),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(getImageNotification(d.type), fit: BoxFit.cover,),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 12, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            d.title!,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 15,),

                        Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.time_solid,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              d.date!,
                              style: TextStyle(
                                //color: Theme.of(context).secondaryHeaderColor, 
                                fontSize: 13,
                              ),
                            ),
                            
                            
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
          
          ),
      onTap: () {
        
         nextScreen(context, NotificationDetails(data: d));   
      },
    );
  }

}

String getImageNotification( String? type ) {
  switch (type) {
    case 'Nova Meditação': 
       return 'assets/images/star_escutando_small.png';
    case 'Nova Funcionalidade no App': 
       return 'assets/images/logo_meditabk_2020.png';
    case 'Atividade Especial na Agenda':
      return 'assets/images/star_agenda_small.png';  
    case 'Aviso Especial':
      return  'assets/images/star_small.png'; 
    default: 
    return 'assets/images/star_small.png'; 
  }

}