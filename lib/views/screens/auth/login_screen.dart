import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
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
            const Text(
              "Login",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
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
                authController.loginUser(_emailController.text.trim(),
                    _passwordController.text.trim());
              },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(width * .85, height * .05),
                  backgroundColor: buttonColor),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You don't have account ? ",
                    style: TextStyle(color: buttonColor)),
                InkWell(
                    onTap: () {},
                    child: const Text(
                      "Register",
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
