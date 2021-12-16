import 'dart:convert';

class MeditationLog {
  int? duration;
  DateTime? date;
  String? type; // timer or guided


  MeditationLog({
    this.duration,
    this.date,
    this.type,
  });


  static Map<String, dynamic> toMap(MeditationLog log) {
    return {
      'duration': log.duration,
      'date': log.date?.millisecondsSinceEpoch,
      'type': log.type,
    };
  }

  factory MeditationLog.fromMap(Map<String, dynamic>? map) {
    //if (map == null) return null;
  
    return MeditationLog(
      duration: map!['duration'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      type: map['type'],
    );
  }

  //String toJson() => json.encode(toMap());
  //factory MeditationLog.fromJson(String source) => MeditationLog.fromMap(json.decode(source));

  static String encodeMeditationStatistics(List<MeditationLog> logs) => json.encode(
        logs.map<Map<String, dynamic>>((log) => MeditationLog.toMap(log))
            .toList(),
      );

  static List<MeditationLog> decodeMeditationStatistics(String logs) =>
      (json.decode(logs) as List<dynamic>)
          .map<MeditationLog>((item) => MeditationLog.fromMap(item))
          .toList();
}
