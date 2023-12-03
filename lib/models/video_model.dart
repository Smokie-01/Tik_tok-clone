import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoModel {
  String userName;
  String videoId;
  String uid;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoURL;
  String thumbNail;
  String profilePhoto;
  VideoModel({
    required this.userName,
    required this.videoId,
    required this.uid,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoURL,
    required this.thumbNail,
    required this.profilePhoto,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'videoId': videoId,
      'uid': uid,
      'likes': likes,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'songName': songName,
      'caption': caption,
      'videoURL': videoURL,
      'thumbNail': thumbNail,
      'profilePhoto': profilePhoto,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      userName: map['userName'] as String,
      videoId: map['videoId'] as String,
      uid: map['uid'] as String,
      likes: List.from((map['likes'] as List)),
      commentCount: map['commentCount'] as int,
      shareCount: map['shareCount'] as int,
      songName: map['songName'] as String,
      caption: map['caption'] as String,
      videoURL: map['videoURL'] as String,
      thumbNail: map['thumbNail'] as String,
      profilePhoto: map['profilePhoto'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
