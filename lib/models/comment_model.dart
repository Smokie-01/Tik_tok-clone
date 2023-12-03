import 'dart:convert';

class CommentModel {
  String comment;
  String userName;
  final datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String commentID;
  CommentModel({
    required this.comment,
    required this.userName,
    required this.datePublished,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.commentID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'userName': userName,
      'likes': likes,
      'profilePhoto': profilePhoto,
      'uid': uid,
      'commentID': commentID,
      'datePublished': datePublished
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: map['comment'] as String,
      userName: map['userName'] as String,
      likes: List.from((map['likes'] as List)),
      profilePhoto: map['profilePhoto'] as String,
      datePublished: map['datePublished'],
      uid: map['uid'] as String,
      commentID: map['commentID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
