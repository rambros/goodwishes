import '/app/shared/comment/comment.dart';

class StepModel {
  final String? documentId;
  final String? title;
  // final String? authorId;
  // final String? authorName;
  // final String? authorText;
  // final String? authorMusic;
  final String? date;
  final bool? featured;
  //final String? imageFileName;
  //final String? imageUrl;
  final String? audioFileName;
  final String? audioDuration;
  final String? audioUrl; 
  final String? callText;
  final String? detailsText; 
  int? numPlayed;
  int? numLiked;
  List<String>? category;
  List<String>? titleIndex;
  List<Comment>? comments;


  StepModel({
    required this.title,
    this.documentId,
    this.audioUrl,
    this.audioFileName,
    this.audioDuration,
    this.date,
    this.featured,
    this.category,
    this.numPlayed,
    this.numLiked,
    this.titleIndex,
    this.comments,
    this.callText,
    this.detailsText,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'audioUrl': audioUrl,
      'audioFileName': audioFileName,
      'audioDuration': audioDuration,
      'date' : date,
      'featured' : featured,
      'numPlayed': numPlayed,
      'numLiked' : numLiked,
      'callText' : callText,
      'detailsText': detailsText,
      //'category': category == null ? [] : List<String>.from(category!.map((x) => x)),
      'titleIndex': titleIndex == null ? [] : List<String>.from(titleIndex!.map((x) => x)),
      'comments': comments == null ? [] : List<Comment>.from(comments!.map((x) => x.toMap())),
    };
  }

  static StepModel fromMap(Map<String, dynamic> map, String? documentId) {
    //if (map == null) return null;

    return StepModel(
      title: map['title'],
      date: map['date'],
      //imageUrl: map['imageUrl'],
      //imageFileName: map['imageFileName'],
      audioUrl: map['audioUrl'],
      audioFileName: map['audioFileName'],
      audioDuration: map['audioDuration'],
      documentId: documentId,
      //authorId: map['authorId'],
      //authorName: map['authorName'],
      //authorText: map['authorText'],
      //authorMusic: map['authorMusic'],
      featured: map['featured'],
      numLiked: map['numLiked'],
      numPlayed: map['numPlayed'],
      callText: map['callText'],
      detailsText: map['detailsText'],
      //category: map['category'] == null ? [] : List<String>.from(map['category'].map((x) => x)),
      titleIndex: map['titleIndex'] == null ? [] : List<String>.from(map['titleIndex'].map((x) => x)),
      comments: map['comments'] == null ? [] : List<Comment>.from(map['comments'].map((x) => Comment.fromMap(x)).toList()),
    );
  }
}
