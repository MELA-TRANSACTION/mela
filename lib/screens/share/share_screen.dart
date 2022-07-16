import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';

import 'package:mela/models/product.dart';
import 'package:mela/screens/share/share_finish_screen.dart';

enum ScreenAction { withDraw, share }

class ShareScreen extends StatefulWidget {
  const ShareScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  String destinateur = '';
  double amount = 0;
  ScreenAction currentScreen = ScreenAction.share;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Operations"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          //vertical: 24,
        ),
        children: [
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Choisir votre operation",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).primaryColor,
            ),
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentScreen = ScreenAction.share;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        color: currentScreen == ScreenAction.share
                            ? Colors.black
                            : Theme.of(context).primaryColor,
                        border: currentScreen != ScreenAction.share
                            ? Border.all(color: Colors.black)
                            : Border.all(color: Colors.black),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          "Partage",
                          style: TextStyle(
                            color: currentScreen == ScreenAction.share
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentScreen = ScreenAction.withDraw;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: currentScreen == ScreenAction.withDraw
                            ? Colors.orange
                            : Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        border: currentScreen != ScreenAction.withDraw
                            ? Border.all(color: Colors.black)
                            : Border.all(color: Colors.orange),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: Text(
                          "Achat",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 56,
          ),
          IntlPhoneField(
            onChanged: (v) => {
              setState(
                () {
                  destinateur = v.completeNumber;
                },
              )
            },
            initialCountryCode: "CD",
            showCountryFlag: false,
            style: const TextStyle(
              color: Colors.black,
            ),
            dropdownTextStyle: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: const Text(
                "Destinateur",
                style: TextStyle(color: Colors.grey),
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: Icon(
                  Icons.phone_iphone_rounded,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                amount = double.parse(value);
              });
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "0.00",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
              label: Text(
                "Montant",
                style: TextStyle(color: Colors.grey),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(top: 13.0),
                child: Text(
                  'CDF',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 56,
          ),
          currentScreen == ScreenAction.share
              ? BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthSuccess) {
                      if (state.user.balance.amount > 0 &&
                          amount < state.user.balance.amount) {
                        return ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Partager"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 0,
                            ),
                            primary: Colors.black,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            const Text(
                              "Balance insuffisante",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Fermer"),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 0,
                                ),
                                primary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    return Container();
                  },
                )
              : BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthSuccess) {
                      if (state.user.balance.amount > 0 &&
                          amount < state.user.balance.amount) {
                        return ElevatedButton(
                          onPressed: () {
                            if (destinateur.length == 13) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ShareFinishScreen(
                                    amount: amount,
                                    receiver: destinateur,
                                    typeTrans: "Retirer",
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Acheter",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 0,
                            ),
                            elevation: 0,
                            primary: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            const Text(
                              "Balance insuffisante",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // if (destinateur.length == 13) {
                                //   Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //       builder: (context) => ShareFinishScreen(
                                //         amount: amount,
                                //         receiver: destinateur,
                                //         typeTrans: "Retirer",
                                //       ),
                                //     ),
                                //   );
                                // }
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Fermer",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 0,
                                ),
                                elevation: 0,
                                primary: Colors.orange,
                                minimumSize: const Size.fromHeight(40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    return Container();
                  },
                )
        ],
      ),
    );
  }
}
