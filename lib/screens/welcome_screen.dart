import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';

enum AppScreen { LOGIN, REGISTER, WELCOM }

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var appScreen = AppScreen.WELCOM;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  String _phoneLogin = "";
  String _phoneRegistre = "";

  TextEditingController passwordLogin = TextEditingController();
  TextEditingController passwordRegister = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (appScreen == AppScreen.LOGIN) {
      return login();
    } else if (appScreen == AppScreen.REGISTER) {
      return register();
    } else {
      return defaultScreen();
    }
  }

  Widget defaultScreen() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Mela",
                  style: GoogleFonts.comfortaa(
                    fontSize: 70,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SvgPicture.asset(
                  "images/wine2.svg",
                  height: 160,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Mon wallet pour la biere",
                  style: GoogleFonts.comfortaa(
                    fontSize: 20,
                    color: Colors.blue[100],
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  setState(() {
                    appScreen = AppScreen.LOGIN;
                  });
                });
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 16),
                primary: Colors.amber[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                //minimumSize: Size.fromWidth(100),
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  appScreen = AppScreen.REGISTER;
                });
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 96, vertical: 16)),
              child: const Text(
                "Creer compte",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 56,
            )
          ],
        ),
      ),
    );
  }

  Widget register() {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey1,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Text(
                    "Enregistrement",
                    style: TextStyle(fontSize: 32, color: Colors.blue[50]),
                  ),
                  const Text(
                    "Mela",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 56,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Ex: Victor ",
                  label: Text("Nom utilisateur"),
                  prefixIcon: Icon(CupertinoIcons.person),
                ),
                style: const TextStyle(color: Colors.white),
                controller: name,
              ),
              const SizedBox(
                height: 16,
              ),
              IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                initialCountryCode: 'CD',
                //showCountryFlag: false,
                dropdownTextStyle: const TextStyle(color: Colors.white),
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (phone) {
                  setState(() {
                    _phoneRegistre = phone.completeNumber;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Ex: 00000000 ",
                  label: Text("Mot de passe"),
                  prefixIcon: Icon(CupertinoIcons.lock),
                ),
                style: const TextStyle(color: Colors.white),
                controller: passwordRegister,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return ElevatedButton(
                      onPressed: () {},
                      child: const Text("Loading ..."),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (formKey1.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(Register(
                            name.text, _phoneRegistre, passwordRegister.text));
                      }
                    },
                    child: const Text("Creer compte"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    appScreen = AppScreen.WELCOM;
                  });
                },
                child: const Text(
                  "Back",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget login() {
    return Scaffold(
      //appBar: AppBar(),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(
              height: 40,
            ),
            Column(
              children: const [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                Text(
                  "Mela",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            const SizedBox(
              height: 16,
            ),
            IntlPhoneField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
              initialCountryCode: 'CD',
              //showCountryFlag: false,
              dropdownTextStyle: const TextStyle(color: Colors.white),
              onChanged: (phone) {
                setState(() {
                  _phoneLogin = phone.completeNumber;
                });
              },
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              controller: passwordRegister,
              decoration: const InputDecoration(
                hintText: "Ex: 00000000 ",
                label: Text("Mot de passe"),
                prefixIcon: Icon(CupertinoIcons.lock),
              ),
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return ElevatedButton(
                    onPressed: () {},
                    child: const Text("Loading ..."),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context)
                          .add(Login(_phoneLogin, passwordLogin.text));
                    }
                  },
                  child: const Text("Connexion"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  appScreen = AppScreen.WELCOM;
                });
              },
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
