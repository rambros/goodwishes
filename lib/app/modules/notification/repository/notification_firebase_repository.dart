
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'interface_notification_repository.dart';

class NotificationFirebaseRepository  implements INotificationRepository {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future  getData(DocumentSnapshot? _lastVisible) async {
    QuerySnapshot rawData;
    try {
      if (_lastVisible == null) {
        rawData = await firestore
            .collection('notifications')
            .doc('custom')
            .collection('list')
            .orderBy('timestamp', descending: true)
            .limit(5)
            .get();
      } else {
        rawData = await firestore
            .collection('notifications')
            .doc('custom')
            .collection('list')
            .orderBy('timestamp', descending: true)
            .startAfter([_lastVisible['timestamp']])
            .limit(5)
            .get();
      }      
      return rawData;
    } catch (e) {
      if (e is PlatformException) {
         return e.message;
      }
      return e.toString();
    }
  }
}
