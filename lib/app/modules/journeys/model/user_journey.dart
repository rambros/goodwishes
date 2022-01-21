import 'dart:convert';

import 'user_step.dart';

class UserJourney {
  final String? uid;
  final String userId;
  final String journeyId;
  final String? title;
  final String? description;
  final String? imageFileName;
  final String? imageUrl;
  final DateTime dateStarted;
  DateTime? dateCompleted;
  DateTime? lastAccessDate;
  final int? stepsTotal;
  int? stepsCompleted;
  List<UserStep>? userSteps;
  String? status;  // completed, ongoing

  UserJourney({
    this.uid,
    required this.userId, 
    required this.journeyId, 
    this.title, 
    this.description, 
    this.imageUrl,
    this.imageFileName,
    required this.dateStarted, 
    this.dateCompleted, 
    this.lastAccessDate, 
    this.stepsCompleted, 
    this.stepsTotal, 
    this.userSteps, 
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userId': userId,
      'journeyId': journeyId,
      'title': title,
      'description': description,
      'imageFileName': imageFileName,
      'imageUrl': imageUrl,
      'dateStarted': dateStarted.millisecondsSinceEpoch,
      'dateCompleted': dateCompleted?.millisecondsSinceEpoch,
      'lastAccessDate': lastAccessDate?.millisecondsSinceEpoch,
      'stepsTotal': stepsTotal,
      'stepsCompleted': stepsCompleted,
      'userSteps': userSteps?.map((x) => x.toMap()).toList(),
      'status': status,
    };
  }

  factory UserJourney.fromMap(Map<String, dynamic> map) {
    return UserJourney(
      uid: map['uid'],
      userId: map['userId'] ?? '',
      journeyId: map['journeyId'] ?? '',
      title: map['title'],
      description: map['description'],
      imageFileName: map['imageFileName'],
      imageUrl: map['imageUrl'],
      dateStarted: DateTime.fromMillisecondsSinceEpoch(map['dateStarted']),
      dateCompleted: map['dateCompleted'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateCompleted']) : null,
      lastAccessDate: map['lastAccessDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['lastAccessDate']) : null,
      stepsTotal: map['stepsTotal']?.toInt(),
      stepsCompleted: map['stepsCompleted']?.toInt(),
      userSteps: map['userSteps'] != null ? List<UserStep>.from(map['userSteps']?.map((x) => UserStep.fromMap(x))) : null,
      status: map['status'],
    );
  }

  factory UserJourney.fromMapAndUid(Map<String, dynamic> map, String uid) {
      map['uid'] = uid;
      return UserJourney.fromMap(map);
  }

  String toJson() => json.encode(toMap());

  factory UserJourney.fromJson(String source) => UserJourney.fromMap(json.decode(source));
}
