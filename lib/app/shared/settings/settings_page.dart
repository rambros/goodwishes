import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '/app/shared/services/notification_service.dart';
import '/app/shared/utils/ui_utils.dart';

import 'settings_controller.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState
    extends ModularState<SettingsPage, SettingsController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    //controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _notificationsService = Modular.get<NotificationService>();
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.blueAccent,
          title: Text('Configurações'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  // initialValue: {
                  //   'darkMode': controller.darkTheme ?? 'false',
                  // },
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //verticalSpaceSmall,
                      Observer(
                        builder: (BuildContext context) {
                          return FormBuilderSwitch(
                            title: Text(
                                     'Tema escuro',
                                     style: TextStyle(fontSize: 16),
                            ),
                            name: 'temaEscuro',
                            activeColor: Theme.of(context).accentColor,
                            initialValue: controller.isDarkTheme,
                            onChanged: (value) =>
                                controller.setDarkTheme(value),
                          );
                        },
                      ),
                      verticalSpaceSmall,
                      FormBuilderSwitch(
                            title: Text(
                                    'Receber notificações',
                                     style: TextStyle(fontSize: 16),
                            ),
                            name: 'notifications',
                            activeColor: Theme.of(context).accentColor,
                            initialValue: _notificationsService.subscribed ?? true,
                            onChanged: (bool) {
                              _notificationsService.fcmSubscribe(bool!);
                              setState(() { });
                            }
                      ),
                    ],
                  ),
                ),
                verticalSpaceMedium,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          _fbKey.currentState!.save();
                          if (_fbKey.currentState!.validate()) {
                            print(_fbKey.currentState!.value);
                            var form = _fbKey.currentState!.value;
                            controller.setDarkTheme(
                              form['temaEscuro'],
                            );
                          } else {
                            print('validation failed');
                          }
                        },
                        child: Text(
                          'Atualizar',
                          style: TextStyle(
                               //color: Colors.white,
                            ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    // Expanded(
                    //   child: MaterialButton(
                    //     color: Theme.of(context).accentColor,
                    //     child: Text(
                    //       'Reset',
                    //       style: TextStyle(
                    //             //color: Colors.white,
                    //           ),
                    //     ),
                    //     onPressed: () {
                    //       _fbKey.currentState.reset();
                    //     },
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
