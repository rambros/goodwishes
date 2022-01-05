import 'package:flutter/foundation.dart';

import 'step_model.dart';

class Journey {
  final String? journeyId;
  final String? title;
  final String? description;
  final String? imageFileName;
  final String? imageUrl;
  int? stepsTotal;
  String? status;   // draft, published
  List<StepModel>? steps;

  Journey({
    this.journeyId,
    this.title,
    this.description,
    this.imageUrl,
    this.imageFileName,
    this.stepsTotal,
    this.status,
    this.steps,
  });

  Map<String, dynamic> toMap() {
    return {
      'journeyId': journeyId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'imageFileName': imageFileName,
      'stepsTotal': stepsTotal,
      'status': status,
      'steps': steps == null ? [] : List<StepModel>.from(steps!.map((x) => x.toMap())),
    };
  }

  factory Journey.fromMap(Map<String, dynamic> map, String? documentId) {
    return Journey(
      journeyId: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'],
      imageFileName: map['imageFileName'],
      stepsTotal: map['stepsTotal']?.toInt() ?? 0,
      status: map['status'] ?? '',
      steps: map['steps'] == null ? [] : List<StepModel>.from(map['steps']?.map((x) => StepModel.fromMap(x)).toList()),
    );
  }

  @override
  String toString() {
    return 'Journey(journeyId: $journeyId, title: $title, description: $description, stepsTotal: $stepsTotal, status: $status, steps: $steps)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Journey &&
      other.journeyId == journeyId &&
      other.title == title &&
      other.description == description &&
      other.stepsTotal == stepsTotal &&
      other.status == status &&
      listEquals(other.steps, steps);
  }
}
