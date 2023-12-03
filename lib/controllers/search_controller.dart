import 'dart:developer';

import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/models/user.dart';

class SearchUserController extends GetxController {
  final Rx<List<UserModel>> _users = Rx<List<UserModel>>([]);

  List<UserModel> get users => _users.value;

  searchUser(String userName) async {
    _users.bindStream(
      firestore
          .collection("users")
          .where('name', isGreaterThanOrEqualTo: userName)
          .snapshots()
          .map(
        (users) {
          List<UserModel> retVal = [];
          for (var user in users.docs) {
            retVal.add(
              UserModel.fromMap(user.data()),
            );
            log(retVal.length.toString());
          }
          return retVal;
        },
      ),
    );
  }
}
