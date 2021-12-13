import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './app/app_widget.dart';
import './app/app_module.dart';
import 'app/shared/services/service_locator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupServiceLocator();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true); // turn this off after seeing reports in in the console.
  //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(ModularApp(
    module: AppModule(),
    child: AppWidget(),
  ));
}
