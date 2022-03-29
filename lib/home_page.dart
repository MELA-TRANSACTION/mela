import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/screens/screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController controller;
  int page = 0;

  @override
  void initState() {
    controller = PageController(initialPage: page);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: const [
          AccountPage(),
          MapScreen(),
          EventPage(),
        ],
        allowImplicitScrolling: false,
        onPageChanged: (int _page) {
          setState(() {
            page = _page;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          setState(() {
            controller.jumpToPage(1);
          });
        },
        child: const Icon(
          CupertinoIcons.location,
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    controller.jumpToPage(0);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 40, top: 20),
                  child: Column(
                    children: [
                      Icon(
                        CupertinoIcons.app_badge,
                        color: page == 0 ? Colors.deepPurple : Colors.grey[700],
                      ),
                      Text(
                        "Mon compte",
                        style: TextStyle(
                          color:
                              page == 0 ? Colors.deepPurple : Colors.grey[700],
                          fontWeight:
                              page == 0 ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    controller.jumpToPage(2);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 80, top: 20),
                  child: Column(
                    children: [
                      Icon(
                        CupertinoIcons.rocket,
                        color: page == 2 ? Colors.deepPurple : Colors.grey[700],
                      ),
                      Text(
                        "Events",
                        style: TextStyle(
                          color:
                              page == 2 ? Colors.deepPurple : Colors.grey[700],
                          fontWeight:
                              page == 2 ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
