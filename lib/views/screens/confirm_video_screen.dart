import 'dart:io';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class ConfirmVideoScreen extends StatefulWidget {
  const ConfirmVideoScreen(
      {super.key, required this.video, required this.videoPath});

  final File video;
  final String videoPath;

  @override
  State<ConfirmVideoScreen> createState() => _ConfirmVideoScreenState();
}

class _ConfirmVideoScreenState extends State<ConfirmVideoScreen> {
  late VideoPlayerController controller;
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  @override
  void initState() {
    super.initState();

    setState(() {
      controller = VideoPlayerController.file(widget.video);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    // controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                child: VideoPlayer(controller)),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextInputField(
                          labelText: "Song",
                          icon: Icons.music_note,
                          controller: _songNameController),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextInputField(
                          labelText: "Caption",
                          icon: Icons.closed_caption,
                          controller: _captionController),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .85,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: buttonColor),
                    onPressed: () {
                      uploadVideoController.uploadVideo(
                        _songNameController.text.trim(),
                        _captionController.text.trim(),
                        widget.videoPath,
                      );
                    },
                    child: const Text("Share Video")))
          ],
        ),
      ),
    );
  }
}
