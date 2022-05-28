import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';

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
                  labelText: 'Numero de telephone',
                ),
                initialCountryCode: 'CD',
                showCountryFlag: false,
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
                      padding: const EdgeInsets.symmetric(vertical: 20),
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
                    appScreen = AppScreen.login;
                  });
                },
                child: const Text(
                  "Back",
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
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          children: [
            const SizedBox(
              height: 64,
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
                labelText: 'Numero de telephone',
              ),
              initialCountryCode: 'CD',
              showCountryFlag: false,
              dropdownTextStyle: const TextStyle(color: Colors.white),
              onChanged: (phone) {
                setState(() {
                  _phoneLogin = phone.completeNumber;
                });
              },
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              controller: passwordLogin,
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
                  appScreen = AppScreen.register;
                });
              },
              child: const Text(
                "Creer compte",
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
