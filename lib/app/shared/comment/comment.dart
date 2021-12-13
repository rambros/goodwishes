class Comment {

//final String commentId;
final String? userId;
final String? userImageUrl;
final String? userName;
final String? comment;
final String? commentDate;

Comment ({ 
  //this.commentId,
  this.userId,
  this.userImageUrl,
  this.userName,
  this.comment,
  this.commentDate,
});

  Map<String, dynamic> toMap() {
    return {
        //'commentId' : commentId,
        'userId' : userId,
        'userImageUrl' : userImageUrl,
        'userName' : userName,
        'comment': comment,
        'commentDate': commentDate,
    };
  }

  static Comment? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return Comment(
      //testecommentId: map['commentId'],
      userId: map['userId'],
      userImageUrl: map['userImageUrl'],
      userName: map['userName'],
      comment: map['comment'],
      commentDate : map['commentDate'],

      //category: map["category"] == null ? [] : List<String>.from(map["category"].map((x) => x)),
    );
  }


}