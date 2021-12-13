import 'package:cloud_firestore/cloud_firestore.dart';

abstract class INotificationRepository {

Future getData(DocumentSnapshot? _lastVisible);

}