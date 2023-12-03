// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _users = Rx<Map<String, dynamic>>({});
  bool isFollowing = false;

  Map<String, dynamic> get users => _users.value;

  final Rx<String> _uid = "".obs;

  updateId(String uid) {
    _uid.value = uid;
    getUsersData();
  }

  getUsersData() async {
    List<String> thumbNails = [];
    var myVideos = await firestore
        .collection("videos")
        .where("uid", isEqualTo: _uid.value)
        .get();

    for (var video in myVideos.docs) {
      thumbNails.add(video.data()['thumbNail']);
    }

    var userDoc = await firestore.collection("users").doc(_uid.value).get();
    var userdata = userDoc.data();

    String name = userdata!['name'];
    String profileImage = userdata['profileImage'];
    int following = 0;
    int followers = 0;
    int likes = 0;

    for (var videosLike in myVideos.docs) {
      likes += (videosLike.data()['likes'] as List).length;
    }

    var FollowersDoc = await firestore
        .collection("users")
        .doc(_uid.value)
        .collection("Followers")
        .get();

    var FollowingDoc = await firestore
        .collection("users")
        .doc(_uid.value)
        .collection("Following")
        .get();

    followers = FollowersDoc.docs.length;
    following = FollowingDoc.docs.length;

    firestore
        .collection("users")
        .doc(_uid.value)
        .collection("Followers")
        .doc(authController.user!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });
    _users.value = {
      "thumbNails": thumbNails,
      "likes": likes.toString(),
      "Followers": followers.toString(),
      "Following": following.toString(),
      "name": name,
      "profileImage": profileImage,
      "isFollowing": isFollowing,
    };
    update();
  }

  followUser() async {
    var doc = await firestore
        .collection("users")
        .doc(_uid.value)
        .collection("Followers")
        .doc(authController.user!.uid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection("users")
          .doc(_uid.value)
          .collection("Followers")
          .doc(authController.user!.uid)
          .set({});
      await firestore
          .collection("users")
          .doc(authController.user!.uid)
          .collection("Following")
          .doc(_uid.value)
          .set({});

      _users.value
          .update("Followers", (value) => (int.parse(value) + 1).toString());
    } else {
      await firestore
          .collection("users")
          .doc(_uid.value)
          .collection("Followers")
          .doc(authController.user!.uid)
          .delete();
      await firestore
          .collection("users")
          .doc(authController.user!.uid)
          .collection("Following")
          .doc(_uid.value)
          .delete();

      _users.value
          .update("Followers", (value) => (int.parse(value) - 1).toString());
    }
    _users.value.update("isFollowing", (value) => !value);
    update();
  }
}
