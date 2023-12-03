import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/search_controller.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchUserController searchUserController =
      Get.put(SearchUserController());
  final TextEditingController _searchUser = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: SizedBox(
            width: 100,
            child: TextFormField(
              controller: _searchUser,
              onFieldSubmitted: (value) {
                searchUserController.searchUser(_searchUser.text.trim());
              },
              decoration: const InputDecoration(
                  label: Text("Search"),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        body: searchUserController.users.isEmpty
            ? const Center(
                child: Text(
                  "Search User",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
              )
            : ListView.builder(
                itemCount: searchUserController.users.length,
                itemBuilder: (context, index) {
                  var user = searchUserController.users[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(userId: user.uid)));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          backgroundImage: NetworkImage(user.profileImage),
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
      );
    });
  }
}
