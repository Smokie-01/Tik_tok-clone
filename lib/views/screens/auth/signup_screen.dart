import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

import '../../../constants/constants.dart';

const defaultImage =
    "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg";

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TikTok Clone",
                  style: TextStyle(
                      fontSize: 35,
                      color: buttonColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: FileImage(authController.profilePhoto!),
                      radius: 60,
                      backgroundColor: Colors.white,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 70,
                      child: IconButton(
                          onPressed: () {
                            authController.pickImage();
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextInputField(
                      labelText: "User name",
                      icon: Icons.email,
                      controller: _userNameController),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextInputField(
                      labelText: "Email",
                      icon: Icons.email,
                      controller: _emailController),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextInputField(
                    labelText: "Password",
                    icon: Icons.lock,
                    controller: _passwordController,
                    isObscure: true,
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                ElevatedButton(
                  onPressed: () {
                    authController.registerUser(
                        _userNameController.text.trim(),
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        authController.profilePhoto);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * .85, height * .05),
                      backgroundColor: buttonColor),
                  child: const Text("Register"),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ! ",
                        style: TextStyle(color: buttonColor)),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "Login",
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
