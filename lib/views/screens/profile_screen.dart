import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  State<ProfileScreen> createState() => _ProfileCsreenState();
}

class _ProfileCsreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.users.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: const Icon(Icons.person_add_alt_1_outlined),
              centerTitle: true,
              title: Text(profileController.users['name']),
              actions: const [Icon(Icons.more_horiz)],
            ),
            body: SingleChildScrollView(
              child: Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .002,
                    vertical: size.height * .002),
                child: Column(
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                              height: 100,
                              width: 100,
                              imageUrl: profileController.users['profileImage'],
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              fit: BoxFit.cover),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  profileController.users['Following'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  " Following ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                Text(
                                  profileController.users['likes'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  " Likes ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                Text(
                                  profileController.users['Followers'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  " Followers ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            if (authController.user!.uid == widget.userId) {
                              authController.signOut();
                            } else {
                              controller.followUser();
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                authController.user!.uid == widget.userId
                                    ? "Sign Out"
                                    : profileController.users['isFollowing']
                                        ? "Follow"
                                        : "Unfollow",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        GridView.builder(
                            itemCount:
                                profileController.users["thumbNails"].length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Image.network(profileController
                                      .users['thumbNails'][index]),
                                  height: 100,
                                  width: 100,
                                ),
                              );
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
