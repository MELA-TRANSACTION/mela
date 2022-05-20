import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mela/blocs/basket/basket_bloc.dart';
import 'package:mela/models/product.dart';
import 'package:mela/screens/share/share_finish_screen.dart';

enum ScreenAction { withDraw, share }

class ShareScreen extends StatefulWidget {
  const ShareScreen({
    required this.product,
    Key? key,
  }) : super(key: key);

  final Product product;

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  String destinateur = '';
  int quantity = 0;
  ScreenAction currentScreen = ScreenAction.share;
  late Product product;

  @override
  void initState() {
    product = widget.product;
    quantity = widget.product.quantity.ceil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partager avec"),
        leading: Icon(
          CupertinoIcons.chevron_left,
          color: Colors.blue[50],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          //vertical: 24,
        ),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).primaryColor,
            ),
            padding: const EdgeInsets.all(4),
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
                            ? Colors.blue.shade400
                            : Theme.of(context).primaryColor,
                        border: currentScreen != ScreenAction.share
                            ? Border.all(color: Colors.white70)
                            : null,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          "Share",
                          style: TextStyle(
                            color: currentScreen == ScreenAction.share
                                ? Colors.white
                                : Colors.white70,
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
                            ? Colors.orange[800]
                            : Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        border: currentScreen != ScreenAction.withDraw
                            ? Border.all(color: Colors.white70)
                            : null,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          "Retirer",
                          style: TextStyle(
                            color: currentScreen == ScreenAction.withDraw
                                ? Colors.white
                                : Colors.white70,
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
          Row(
            children: [
              Text(
                quantity.ceil().toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              SvgPicture.asset(
                "images/wine.svg",
                height: 24,
                width: 22,
                color: Colors.white,
              ),
              Text(
                product.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity < product.quantity) {
                          quantity++;
                        }
                      });
                    },
                    child: Container(
                      width: 72,
                      height: 48,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity <= 1) {
                          quantity = 1;
                        } else {
                          quantity--;
                        }
                      });
                    },
                    child: Container(
                      width: 72,
                      height: 48,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.minus,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
              color: Colors.white,
            ),
            dropdownTextStyle: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: const Text("Destinateur"),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 72),
            child: Text(
              "Entrer le numero de votre destinateur",
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 56,
          ),
          currentScreen == ScreenAction.share
              ? BlocBuilder<BasketBloc, BasketState>(
                  builder: (context, state) {
                    if (state is BasketLoaded) {
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShareFinishScreen(
                                product: product,
                                quantity: quantity,
                                receiver: destinateur,
                                typeTrans: "Partager",
                              ),
                            ),
                          );
                        },
                        child: const Text("Partager"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 0,
                          ),
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {},
                      child: const Text("Loading ..."),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 0,
                        ),
                        primary: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                )
              : BlocBuilder<BasketBloc, BasketState>(
                  builder: (context, state) {
                    if (state is BasketLoaded) {
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShareFinishScreen(
                                product: product,
                                quantity: quantity,
                                receiver: destinateur,
                                typeTrans: "Retirer",
                              ),
                            ),
                          );
                        },
                        child: const Text("Retirer"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 0,
                          ),
                          primary: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {},
                      child: const Text("Loading ..."),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 0,
                        ),
                        primary: Colors.orange[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }
}
