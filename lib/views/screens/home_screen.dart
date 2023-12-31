import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: backgroundColor,
            currentIndex: pageIndex,
            selectedItemColor: Colors.red,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(icon: CustomIcon(), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: "Message"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ]),
        body: Center(child: pages[pageIndex]));
  }
}
