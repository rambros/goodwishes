import 'dart:convert';

import '/app/shared/comment/comment.dart';

class StepModel {
  final String? documentId;
  final String? title;
  final String? descriptionText;
  final int stepNumber;
  final String? inspirationTitle;
  final String? inspirationAudioURL;
  final String? inspirationFileName;
  final String? inspirationDuration;
  final String? inspirationText;
  final String? meditationTitle;
  final String? meditationAudioURL;
  final String? meditationFileName;
  final String? meditationDuration;
  final String? meditationText;
  final String? practiceTitle;
  final String? practiceText;
  final String? date;
  int? numPlayed;
  int? numLiked;
  List<Comment>? comments;


  StepModel({
    this.documentId,
    required this.title,
    this.descriptionText,
    this.stepNumber = 0,
    this.inspirationTitle,
    this.inspirationAudioURL,
    this.inspirationFileName,
    this.inspirationDuration,
    this.inspirationText,
    this.meditationTitle,
    this.meditationAudioURL,
    this.meditationFileName,
    this.meditationDuration,
    this.meditationText,
    this.practiceTitle,
    this.practiceText,
    this.date,
    this.numPlayed,
    this.numLiked,
    this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'title': title,
      'descriptionText': descriptionText,
      'stepNumber': stepNumber,
      'inspirationTitle': inspirationTitle,
      'inspirationAudioURL': inspirationAudioURL,
      'inspirationFileName': inspirationFileName,
      'inspirationDuration': inspirationDuration,
      'inspirationText': inspirationText,
      'meditationTitle': meditationTitle,
      'meditationAudioURL': meditationAudioURL,
      'meditationFileName': meditationFileName,
      'meditationDuration': meditationDuration,
      'meditationText': meditationText,
      'practiceTitle': practiceTitle,
      'practiceText': practiceText,
      'numPlayed': numPlayed,
      'numLiked': numLiked,
      'date': date,
      'comments': comments?.map((x) => x.toMap()).toList(),
    };
  }

  static StepModel fromMap(Map<String, dynamic> map) {
    return StepModel(
      documentId: map['documentId'],
      title: map['title'],
      descriptionText: map['descriptionText'],
      stepNumber: map['stepNumber'],
      inspirationTitle: map['inspirationTitle'], 
      inspirationAudioURL: map['inspirationAudioURL'],
      inspirationFileName: map['inspirationFileName'],
      inspirationDuration: map['inspirationDuration'],
      inspirationText: map['inspirationText'],
      meditationTitle: map['meditationTitle'],
      meditationAudioURL: map['meditationAudioURL'],
      meditationFileName: map['meditationFileName'],
      meditationDuration: map['meditationDuration'],
      meditationText: map['meditationText'],
      practiceTitle: map['practiceTitle'],
      practiceText: map['practiceText'],
      date: map['date'],
      numLiked: map['numLiked'],
      numPlayed: map['numPlayed'],
      comments: map['comments'] == null ? null : List<Comment>.from(map['comments'].map((x) => Comment.fromMap(x)).toList()),
    );
  }

  String toJson() => json.encode(toMap());

  //factory StepModel.fromJson(String source) => StepModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StepModel(documentId: $documentId, title: $title, date: $date, stepNumber: $stepNumber, inspirationTitle: $inspirationTitle, inspirationAudioURL: $inspirationAudioURL, inspirationFileName: $inspirationFileName, inspirationDuration: $inspirationDuration, inspirationText: $inspirationText, meditationTitle: $meditationTitle, meditationAudioURL: $meditationAudioURL, meditationFileName: $meditationFileName, meditationDuration: $meditationDuration, meditationText: $meditationText, practiceTitle: $practiceTitle, practiceText: $practiceText, descriptionText: $descriptionText, numPlayed: $numPlayed, numLiked: $numLiked, comments: $comments)';
  }

  
}
