import 'package:tiktok_clone/models/video_model.dart';
import 'package:video_compress/video_compress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constants.dart';

class UploadVideoController extends GetxController {
  // TO acceses All this Method Globally

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  //Upload video to Storage
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("videos").child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  //Gtting ThumbNail
  _getThumbNail(String videoPath) async {
    final thumbNail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbNail;
  }

  //Upload Image to Storage ;
  _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("ThumbNail").child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbNail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //Upload Video
  uploadVideo(
    String songName,
    String caption,
    String videoPath,
  ) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot docs =
          await firestore.collection("users").doc(uid).get();

      var allDocs = await firestore.collection("videos").get();
      int len = allDocs.docs.length;

      String videoURL = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbNail = await _uploadImageToStorage("Video $len", videoPath);

      VideoModel video = VideoModel(
          userName: (docs.data()! as Map<String, dynamic>)['name'],
          videoId: "video $len",
          uid: uid,
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoURL: videoURL,
          thumbNail: thumbNail,
          profilePhoto: (docs.data() as Map<String, dynamic>)['profileImage']);

      await firestore
          .collection("videos")
          .doc("video $len")
          .set(video.toMap())
          .whenComplete(() {});
      Get.back();
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
