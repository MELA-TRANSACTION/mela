import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0e2763),
      body: OnBoardingSlider(
        headerBackgroundColor: const Color(0xff0e2763),
        pageBackgroundColor: const Color(0xff0e2763),

        finishButtonColor: Colors.amber,
        finishButtonTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        finishButtonText: 'Register',
        skipTextButton: const Text('Skip'),
        onFinish: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignInScreen(providerConfigs: [
                GoogleProviderConfiguration(clientId: "876159011335-cnrdhstg0ajo74ti7e5db0hrq17ka07h.apps.googleusercontent.com"),
                PhoneProviderConfiguration(),
              ]),
            ),
          );
        },
        //trailing: Text('Login'),
        background: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
            padding: const EdgeInsets.all(44),
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(180),
            ),
            child: SvgPicture.asset(
              'images/celebration_beer.svg',
              width: 200,
              height: 200,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
            padding: const EdgeInsets.all(44),
            child: SvgPicture.asset(
              'images/undraw_beer.svg',
              width: 200,
              height: 200,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
            padding: const EdgeInsets.all(44),
            decoration: BoxDecoration(
              //  color: Colors.white,
              borderRadius: BorderRadius.circular(180),
            ),
            child: SvgPicture.asset(
              'images/undraw_energizer.svg',
              width: 200,
              height: 200,
            ),
          ),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 380,
                ),
                Text(
                  'Partager avec  ',
                  style: GoogleFonts.comfortaa(
                    fontSize: 38,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "La vie c'est le partage, vous avez des proches avec qui partager votre boisson.",
                  style: GoogleFonts.comfortaa(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 380,
                ),
                Text(
                  'Retirer ',
                  style: GoogleFonts.comfortaa(
                    fontSize: 40,
                    color: Colors.amber,
                  ),
                ),
                Text(
                  'Retirer et savourer votre biere',
                  style: GoogleFonts.comfortaa(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 380,
                ),
                Text(
                  "Rejoin la communaute MELA en se connectant simplement. Nous vous attendons avec chaleur!!!",
                  style: GoogleFonts.comfortaa(
                    fontSize: 22,
                    color: Colors.amber,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
