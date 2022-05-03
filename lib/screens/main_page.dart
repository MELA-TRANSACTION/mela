import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/screens/pages/account_page.dart';
import 'package:mela/screens/pages/game_page.dart';
import 'package:mela/screens/pages/profile_page.dart';
import 'package:mela/screens/pages/trans_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int p = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: p, keepPage: true);
    super.initState();
  }

  void onPageChanged(int page) {
    setState(() {
      p = page;
    });
  }

  void onNavTapped(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          AccountPage(),
          GamePage(),
          TransPage(),
          ProfilePage(),
        ],
        controller: _controller,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onNavTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: p,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.square_on_square,
            ),
            label: "Account",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.game_controller,
            ),
            label: "Jeux",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.arrow_2_squarepath,
            ),
            label: "Trans",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
