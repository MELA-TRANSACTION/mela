import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mela/blocs/basket/basket_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/models/product.dart';

class RechargeBasketScreen extends StatefulWidget {
  const RechargeBasketScreen({Key? key}) : super(key: key);

  @override
  State<RechargeBasketScreen> createState() => _RechargeBasketScreenState();
}

class _RechargeBasketScreenState extends State<RechargeBasketScreen> {
  String phoneDestinateur = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recharge client"),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if (state is BasketLoaded) {
                          return ListView.builder(
                            itemCount: state.items.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var p = state.items[index];
                              return ProdBasketTile(
                                product: p,
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: MediaQuery.of(context).size.height / 2,
              //color: Colors.blue.shade100,
              child: ListView(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Destinateur",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: 'numero du client',
                    ),
                    initialCountryCode: 'CD',
                    showCountryFlag: false,
                    dropdownTextStyle: const TextStyle(color: Colors.white),
                    onChanged: (phone) {
                      setState(() {
                        phoneDestinateur = phone.completeNumber;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<BasketBloc, BasketState>(
                    builder: (context, state) {
                      if (state is BasketLoaded) {
                        return ElevatedButton(
                          onPressed: () {
                            print(state.items.map((e) => e.toJson()).toList());
                            BlocProvider.of<TransBloc>(context).add(
                              AddTransactionEvent(
                                products: state.items,
                                destinateur: phoneDestinateur,
                              ),
                            );
                            // BlocProvider.of<BasketBloc>(context)
                            //     .add(InitBasketEvent());
                          },
                          child: const Text(
                            "Terminer",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 40,
                            ),
                          ),
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            // BlocProvider.of<TransBloc>(context).add(AddTransactionEvent(products: products, destinateur: destinateur));
                          },
                          child: const Text(
                            "Loading ...",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 40,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProdBasketTile extends StatelessWidget {
  const ProdBasketTile({
    required this.product,
    Key? key,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 120,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  "images/wine.svg",
                  height: 64,
                  width: 44,
                  color: Colors.white,
                ),
                Text(
                  product.name,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${product.quantity} items",
                  style: const TextStyle(
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -10,
            top: -10,
            child: IconButton(
              onPressed: () {
                BlocProvider.of<BasketBloc>(context)
                    .add(BasketItemDeleted(product));
                BlocProvider.of<BasketBloc>(context).add(BasketStarted());
              },
              icon: const Icon(
                CupertinoIcons.xmark,
                color: Colors.orange,
              ),
            ),
          )
        ],
      ),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
