// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/views/screens/confirm_video_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  pickVideo(ImageSource source, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: source);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmVideoScreen(
            video: File(video.path),
            videoPath: video.path,
          ),
        ),
      );
    }
  }

  showOptionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                child: const Row(
                  children: [
                    Icon(Icons.image),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Gallery"),
                    ),
                  ],
                ),
                onPressed: () {
                  pickVideo(ImageSource.gallery, context);
                },
              ),
              SimpleDialogOption(
                child: const Row(
                  children: [
                    Icon(Icons.camera),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Camera"),
                    ),
                  ],
                ),
                onPressed: () {
                  pickVideo(ImageSource.camera, context);
                },
              ),
              SimpleDialogOption(
                child: const Row(
                  children: [
                    Icon(Icons.close),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Close"),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 100,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            showOptionDialog(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
          child: const Text("Add video"),
        ),
      )),
    );
  }
}
