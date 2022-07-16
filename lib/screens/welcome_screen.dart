import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';
import 'package:mela/main.dart';

enum AppScreen { login, register }

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var appScreen = AppScreen.login;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  String _phoneLogin = "";
  String _phoneRegistre = "";

  TextEditingController passwordLogin = TextEditingController();
  TextEditingController passwordRegister = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return appScreen == AppScreen.login ? login() : register();
    // } else if (appScreen == AppScreen.register) {
    //   return register();
    // } else if (appScreen == AppScreen.distributor) {
    //   return loginDistributor();
    // }
  }

  Widget register() {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  SvgPicture.asset(
                    "images/logo_mela_svg.svg",
                    height: 64,
                  ),
                  const Text(
                    "nouveau compte",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
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
                  labelText: 'Numero de telephone',
                ),
                initialCountryCode: 'CD',
                showCountryFlag: false,
                dropdownTextStyle: const TextStyle(color: Colors.black),
                style: const TextStyle(
                  color: Colors.black,
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
                style: const TextStyle(color: Colors.black),
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
                    child: const Text(
                      "Creer un compte",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 56,
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    appScreen = AppScreen.login;
                  });
                },
                child: const Text(
                  "Retour",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
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
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          children: [
            const SizedBox(
              height: 64,
            ),
            Column(
              children: [
                SvgPicture.asset(
                  "images/logo_mela_svg.svg",
                  height: 54,
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "connexion",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            IntlPhoneField(
              decoration: const InputDecoration(
                labelText: 'Numero de telephone',
              ),
              initialCountryCode: 'CD',
              showCountryFlag: false,
              dropdownTextStyle: TextStyle(color: Colors.grey[800]),
              onChanged: (phone) {
                setState(() {
                  _phoneLogin = phone.completeNumber;
                });
              },
              style: const TextStyle(color: Colors.black),
            ),
            TextFormField(
              controller: passwordLogin,
              decoration: const InputDecoration(
                hintText: "Ex: 00000000 ",
                label: Text("Mot de passe"),
                prefixIcon: Icon(CupertinoIcons.lock),
              ),
              style: const TextStyle(color: Colors.black),
              obscureText: true,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Mot de passe oublié ?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
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

                if (state is AuthFailure) {
                  return Column(
                    children: [
                      Text(
                        "${state.authError.message} ",
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              Login(_phoneLogin, passwordLogin.text),
                            );

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RootScreen()));
                          }
                        },
                        child: const Text("Try again"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context)
                          .add(Login(_phoneLogin, passwordLogin.text));

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RootScreen()));
                    }
                  },
                  child: const Text(
                    "Connexion",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
              height: 56,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthFailure) {
                  return Container();
                }
                return TextButton(
                  onPressed: () {
                    setState(() {
                      appScreen = AppScreen.register;
                    });
                  },
                  child: const Text(
                    "Creer un compte",
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
