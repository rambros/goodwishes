
/// Model of Timers that user can persist in repository
class TimerModel {
  final String? documentId;
  final String? title;
  final int? duration;
  final String? preparation;
  final String? soundStartPath;
  final String? soundStartId;
  final int? soundStartDuration;
  final String? soundBackgroundLocation;
  final int? soundBackgroundDuration;
  final String? soundBackgroundId;
  final String? soundBackgroundType;
  final String? soundEndPath;
  final String? soundEndId;
  final int? soundEndDuration;

  TimerModel( {
    this.documentId,
    this.title,
    this.duration,
    this.preparation,
    this.soundStartPath,
    this.soundStartId,
    this.soundStartDuration,
    this.soundBackgroundLocation,
    this.soundBackgroundDuration,
    this.soundBackgroundId,
    this.soundBackgroundType,
    this.soundEndPath,
    this.soundEndId,
    this.soundEndDuration,
  });

    Map<String, dynamic> toMap() {
    return {
      'title': title,
      'duration': duration,
      'preparation': preparation,
      'soundStartPath': soundStartPath,
      'soundStartId': soundStartId,
      'soundStartDuration': soundStartDuration,
      'soundBackgroundLocation': soundBackgroundLocation,
      'soundBackgroundDuration': soundBackgroundDuration,
      'soundBackgroundId': soundBackgroundId,
      'soundBackgroundType': soundBackgroundType,
      'soundEndPath': soundEndPath,
      'soundEndId': soundEndId,
      'soundEndDuration': soundEndDuration,
    };
  }

    static TimerModel? fromMap(Map<String, dynamic>? map, String documentId) {
    if (map == null) return null;

    return TimerModel(
      title: map['title'],
      duration: map['duration'],
      preparation: map['preparation'],
      soundStartPath: map['soundStartPath'],
      soundStartId: map['soundStartId'],
      soundStartDuration: map['soundStartDuration'],
      soundBackgroundLocation: map['soundBackgroundLocation'],
      soundBackgroundDuration: map['soundBackgroundDuration'],
      soundBackgroundId: map['soundBackgroundId'],
      soundBackgroundType: map['soundBackgroundType'],
      soundEndPath: map['soundEndPath'],
      soundEndId: map['soundEndId'],
      soundEndDuration: map['soundEndDuration'],
      documentId: documentId,
      // soundBackground: map['soundBackground'] == null ? [] : TimerMusic.fromMap(map['soundBackground'],documentId),
    );
  }
  
}