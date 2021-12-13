import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? title;
  String? description;
  String? date;
  String? timestamp;
  String? type;

  NotificationModel({
    this.title,
    this.description,
    this.date,
    this.timestamp,
    this.type
  });


  factory NotificationModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot){
    var d = snapshot.data()!;
    return NotificationModel(
      title: d['title'],
      description: d['description'],
      date: d['date'],
      timestamp: d['timestamp'],
      type: d['type']
    );
  }
}