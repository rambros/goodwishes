import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_controller.dart';
import 'shared/services/dialog_manager.dart';
import 'shared/services/dialog_service.dart';

class AppWidget extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends ModularState<AppWidget, AppController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    GlobalConfiguration().loadFromAsset('app_settings.json');
    final dialogService = Modular.get<DialogService>();
    return Observer(
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            FormBuilderLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
            Locale('en', ''),
            // ... other locales the app supports
          ],
          locale: const Locale('pt', 'BR'),
          builder: (context, widget) => Navigator(
            key: dialogService.dialogNavigationKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => DialogManager(
                child: widget,
              ),
            ),
          ),
          title: 'MeditaBK',
          theme: controller.currentTheme,
          initialRoute: '/splash',
        ).modular();
      },
    );
  }
}
