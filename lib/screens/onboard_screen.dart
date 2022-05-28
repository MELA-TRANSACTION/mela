import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/models/app_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;
  bool isLastPage = false;
  int currentPage = 0;
  @override
  initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView.builder(
          controller: pageController,
          onPageChanged: (int page) {
            setState(() => currentPage = page);
            if (page == 2) {
              setState(() => isLastPage = true);
            }
          },
          itemCount: appData.length,
          itemBuilder: (context, index) {
            return buildPage(
              appData[index].title,
              appData[index].img,
              appData[index].content,
            );
          },
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () async {
                // naviger vers loginpage
                //setState(() => isLastPage = false);
                Navigator.of(context).pushNamed("welcome");
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setBool("showHome", true);
              },
              child: const Text("Get started"),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(80),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      pageController.jumpToPage(2);
                      setState(
                        () => isLastPage = true,
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SmoothPageIndicator(
                    currentIndex: currentPage,
                    listPaths: appData,
                  ),
                  TextButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildPage(String title, String image, String content) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 44.0, color: Colors.white),
              ),
              const SizedBox(
                height: 24,
              ),
              SvgPicture.asset(
                image,
                height: 220,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SmoothPageIndicator extends StatelessWidget {
  const SmoothPageIndicator({
    Key? key,
    required this.currentIndex,
    required this.listPaths,
  }) : super(key: key);

  final int currentIndex;
  final List<AppModel> listPaths;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: listPaths.map((url) {
        int index = listPaths.indexOf(url);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index
                ? Colors.amber[800]
                : const Color.fromRGBO(0, 0, 0, 0.4),
          ),
        );
      }).toList(),
    );
  }
}
