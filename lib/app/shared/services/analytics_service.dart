import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // FirebaseAnalyticsObserver getAnalyticsObserver() =>
  //     FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties({required String? userId,  String? userRole}) async {
    await _analytics.setUserId(id: userId);
    // Set the user_role
    await _analytics.setUserProperty(name: 'user_role', value: userRole);
  }

  Future setCurrentScreen({String? screenName} ) async {
    await _analytics.setCurrentScreen(screenName: screenName);
  }

  Future logLogin() async {
  await _analytics.logLogin(loginMethod: 'email');
}

Future logSignUp(String signUpMethod) async {
  await _analytics.logSignUp(signUpMethod: signUpMethod);
}

Future logPostCreated({bool? hasImage}) async {
  await _analytics.logEvent(
    name: 'create_post',
    parameters: {'has_image': hasImage},
  );
}

Future logAccessPage({String? page}) async {
  await _analytics.logEvent(
    name: 'access_page',
    parameters: {'page': page},
  );
}

Future logMeditation({
  String? title,
  String? meditationId,
  int? duration,
  String? date,
  String? time,
  String? type,

  }) async {
  await _analytics.logEvent(
    name: 'meditação',
    parameters: {
      'tipo': type,
      'titulo': title,
      'id_medutação': meditationId,
      'duração': duration,
      'data': date,
      'hora': time,
      
      },
  );
}

Future logShareMsg({int? index}) async {
  await _analytics.logEvent(
    name: 'share_msg',
    parameters: {'index_msg': index},
  );
}
      
}