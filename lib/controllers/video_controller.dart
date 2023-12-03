import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/models/video_model.dart';

class VideoController extends GetxController {
  final Rx<List<VideoModel>> _videosList = Rx<List<VideoModel>>([]);

  List<VideoModel> get videos => _videosList.value;

  @override
  void onInit() {
    super.onInit();
    _videosList.bindStream(
      firestore.collection("videos").snapshots().map(
        (query) {
          List<VideoModel> retVal = [];
          for (var element in query.docs) {
            retVal.add(
              VideoModel.fromMap(element.data()),
            );
            log("data added");
          }
          return retVal;
        },
      ),
    );
  }

  likeVideo(String videoId) async {
    var doc = await firestore.collection("videos").doc(videoId).get();
    var uid = authController.user!.uid;

    if (doc.data()!['likes'].contains(uid)) {
      await firestore.collection("videos").doc(videoId).update({
        "likes": FieldValue.arrayRemove([uid])
      });
    } else {
      await firestore.collection("videos").doc(videoId).update(
        {
          "likes": FieldValue.arrayUnion([uid])
        },
      );
    }
  }
}
