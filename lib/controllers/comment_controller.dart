import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<CommentModel>> _comments = Rx<List<CommentModel>>([]);

  List<CommentModel> get comments => _comments.value;

  String postID = "";

  updatePostID(String id) {
    postID = id;
    getCommnets();
  }

  getCommnets() async {
    _comments.bindStream(firestore
        .collection("videos")
        .doc(postID)
        .collection("comments")
        .snapshots()
        .map((comments) {
      List<CommentModel> returnVal = [];
      for (var comment in comments.docs) {
        returnVal.add(CommentModel.fromMap(comment.data()));
      }
      return returnVal;
    }));
  }

  postCommnet(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        var userDoc = await firestore
            .collection("users")
            .doc(authController.user!.uid)
            .get();

        var allDoc = await firestore
            .collection("videos")
            .doc(postID)
            .collection("comments")
            .get();

        int len = allDoc.docs.length;

        CommentModel comment = CommentModel(
            comment: commentText.trim(),
            userName: userDoc.data()!['name'],
            datePublished: DateTime.now(),
            likes: [],
            profilePhoto: userDoc.data()!['profileImage'],
            uid: authController.user!.uid,
            commentID: "comment $len");

        await firestore
            .collection("videos")
            .doc(postID)
            .collection("comments")
            .doc("comment $len")
            .set(comment.toMap());
      }

      var postDoc = await firestore.collection("videos").doc(postID).get();
      await firestore
          .collection("videos")
          .doc(postID)
          .update({'commentCount': (postDoc.data()!['commentCount'] + 1)});
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  likecomments(String commentId) async {
    final userId = authController.user!.uid;
    var comment = await firestore
        .collection("videos")
        .doc(postID)
        .collection("comments")
        .doc(commentId)
        .get();

    if (comment.data()!['likes'].contains(userId)) {
      await firestore
          .collection("videos")
          .doc(postID)
          .collection("comments")
          .doc(commentId)
          .update({
        'likes': FieldValue.arrayRemove([userId])
      });
    } else {
      await firestore
          .collection("videos")
          .doc(postID)
          .collection("comments")
          .doc(commentId)
          .update({
        'likes': FieldValue.arrayUnion([userId])
      });
    }
  }
}
