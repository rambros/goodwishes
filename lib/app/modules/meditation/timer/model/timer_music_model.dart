import 'package:flutter/foundation.dart';

enum MusicType {
  asset,
  file,
  url
}

/// Model of musics that can be incorporated in a Timer 
class TimerMusic {
  final String? documentId;
  final String? title;
  final String? imageFileName;
  final String? imageUrl;
  final String? audioFileName;
  final int? audioDuration;
  final String? audioLocation; 
  String? type; //asset, url, file


  TimerMusic({
    required this.title,
    this.documentId,
    this.imageUrl,
    this.imageFileName,
    this.audioLocation,
    this.audioFileName,
    this.audioDuration,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'imageFileName': imageFileName,
      'audioLocation': audioLocation,
      'audioFileName': audioFileName,
      'audioDuration': audioDuration,
      'type' : type,
    };
  }

  static TimerMusic? fromMap(Map<String, dynamic>? map, String documentId) {
    if (map == null) return null;

    return TimerMusic(
      title: map['title'],
      imageUrl: map['imageUrl'],
      imageFileName: map['imageFileName'],
      audioLocation: map['audioLocation'],
      audioFileName: map['audioFileName'],
      audioDuration: map['audioDuration'],
      documentId: documentId,
      type: map['type'],
    );
  }
}
