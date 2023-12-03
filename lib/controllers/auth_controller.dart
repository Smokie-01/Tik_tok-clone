import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  // global variable to hold the selected image
  final RxString _pickedImage = "".obs;
  String get pickImage => _pickedImage.value;

  // global variable to acces user;
  late Rx<User?> _user;

//gettert which returns the current valu of the user;
  User? get user => _user.value;

  bool isImagePicked = false;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  //Pick Image
  captureImage() async {
    try {
      final pickImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);

      if (pickImage != null) {
        _pickedImage.value = pickImage.path;
      }
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

// Upload Profile image to firebase storage
  Future<String> _uploadImageToFIrebase(File? image) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profilePics")
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();

    return downloadURL;
  }

// registering the user
  registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty && password.isNotEmpty && image != null) {
        // Register the user into firebase
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        String downloadURL = await _uploadImageToFIrebase(image);

        UserModel user = UserModel(
            name: username,
            email: email,
            uid: cred.user!.uid,
            profileImage: downloadURL);

        await firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toMap());
      } else {
        Get.snackbar("Error creating account", "Please Enter all feilds");
      }
    } catch (e) {
      Get.snackbar("Error creating Account", e.toString());
    }
  }

  // Login User
  loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar("Error creating Account", "Please enter all the feilds");
      }
    } catch (e) {
      Get.snackbar("Error creating Account", e.toString());
    }
  }

  signOut() {
    firebaseAuth.signOut();
  }

  clearImage() {
    _pickedImage.value = "";
  }
}
