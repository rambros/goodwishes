import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_service.g.dart';

class NotificationService = _NotificationServiceBase with _$NotificationService;

abstract class _NotificationServiceBase with Store {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final String subscriptionTopic = 'all'; //all
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  bool? _subscribed;
  bool? get subscribed => _subscribed;

  @observable
  int _notificationLength = 0;
  int get notificationLength => _notificationLength;

  @observable
  int _savedNlength = 0;
  int get savedNlength => _savedNlength;

  @observable
  int _notificationFinalLength = 0;
  int get notificationFinalLength => _notificationFinalLength;

  Future handleNotificationlength() async {
    await getNlengthFromSP().then((value) {
      getNotificationLengthFromDatabase().then((_length) {
        _notificationLength = _length;
        _notificationFinalLength = _notificationLength - savedNlength;
      });
    });
  }

  Future<int> getNotificationLengthFromDatabase() async {
    final ref = firestore.collection('item_count').doc('notifications_count');
    var snap = await ref.get();
    if (snap.exists == true) {
      int itemlength = snap['count'] ?? 0;
      return itemlength;
    } else {
      return 0;
    }
  }

  Future getNlengthFromSP() async {
    final sp = await SharedPreferences.getInstance();
    int _savedLength = sp.get('saved length') as int? ?? 0;
    _savedNlength = _savedLength;
  }

  Future saveNlengthToSP() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt('saved length', _notificationLength);
    _savedNlength = _notificationLength;
    await handleNotificationlength();
  }

  Future initFirebasePushNotification(context) async {
    await _requestIOSPermission();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _initializeFlutterLocalNotificationPlugin();
    await handleFcmSubscribtion();
    // Get any messages which caused the application to open from a terminated state.
    var initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await Modular.to.pushNamed('/notification');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var notification = message.notification;
      var android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'logo_branco',
              ),
            ));
      }
    });

    // Also handle any interaction when the app is in the background via aStream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message != null) {
        //Modular.to.pushNamed('/notification');
        print('onMessage: $message');
        showinAppDialog(context, message.data['notification']['title'],
            message.data['notification']['body']);
      }
    });

    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('onMessage: $message');
    //     showinAppDialog(context, message['notification']['title'], message['notification']['body']);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print('onLaunch: $message');
    //     await Modular.to.pushNamed('/notification');
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     await handleNotificationlength();
    //     print('onResume: $message');
    //   },
    // );
  }

  Future _requestIOSPermission() async {
    if (Platform.isIOS) {
      final settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
      //_fcm.requestNotificationPermissions(IosNotificationSettings());
    }
  }

  Future _initializeFlutterLocalNotificationPlugin() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var initializationSettingsAndroid = AndroidInitializationSettings(
        //'@mipmap/logo_meditabk',
        'logo_branco');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future handleFcmSubscribtion() async {
    final sp = await SharedPreferences.getInstance();
    final _getsubcription = sp.getBool('subscribe') ?? true;
    if (_getsubcription == true) {
      await sp.setBool('subscribe', true);
      await _fcm.subscribeToTopic(subscriptionTopic);
      _subscribed = true;
      print('subscribed');
    } else {
      await sp.setBool('subscribe', false);
      await _fcm.unsubscribeFromTopic(subscriptionTopic);
      _subscribed = false;
      print('unsubscribed');
    }
  }

  Future fcmSubscribe(bool isSubscribed) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('subscribe', isSubscribed);
    await handleFcmSubscribtion();
  }

  void showinAppDialog(context, title, body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          title: Text(title),
          subtitle: Text(body), //HtmlWidget(body),
        ),
        actions: <Widget>[
          TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
                Modular.to.pushNamed('/notification');
              }),
        ],
      ),
    );
  }
}
