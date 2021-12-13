import 'package:flutter/foundation.dart';

/// Model of sounds that can be incorporated in a Timer (start, end)
class TimerSound {
  final String? title;
  final String? imageFileId;
  final String? imageUrl;
  final String? audioFilePath;
  final int? audioFileDuration;


  TimerSound({
    required this.title,
    this.imageUrl,
    this.imageFileId,
    this.audioFilePath,
    this.audioFileDuration,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'imageFileId': imageFileId,
      'audioFileName': audioFilePath,
      'audioFileDuration': audioFileDuration,
    };
  }

  static TimerSound? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return TimerSound(
      title: map['title'],
      imageUrl: map['imageUrl'],
      imageFileId: map['imageFileId'],
      audioFilePath: map['audioFilePath'],
      audioFileDuration: map['audioFileDuration'],
    );
  }
}
