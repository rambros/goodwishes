
import 'dart:convert';

import 'step_model.dart';

class UserStep {
  final StepModel step;
  final String status;  //open, closed, completed
  DateTime? dateStarted;
  DateTime? dateCompleted;

  UserStep({
    required this.step,
    required this.status, 
    this.dateStarted, 
    this.dateCompleted, 
  }); 


  Map<String, dynamic> toMap() {
    return {
      'step': step.toMap(),
      'status': status,
      'dateStarted': dateStarted?.millisecondsSinceEpoch,
      'dateCompleted': dateCompleted?.millisecondsSinceEpoch,
    };
  }

  factory UserStep.fromMap(Map<String, dynamic> map) {
    return UserStep(
      step: StepModel.fromMap(map['step']),
      status: map['status'] ?? '',
      dateStarted: map['dateStarted'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateStarted']) : null,
      dateCompleted: map['dateCompleted'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateCompleted']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserStep.fromJson(String source) => UserStep.fromMap(json.decode(source));
}
