import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/account/account_bloc.dart';
import 'package:mela/blocs/basket/basket_bloc.dart';
import 'package:mela/components/basket_item.dart';

import 'package:mela/models/product.dart';

class WithDrawFinish extends StatefulWidget {
  const WithDrawFinish({Key? key, required this.distributor}) : super(key: key);
  final String distributor;

  @override
  State<WithDrawFinish> createState() => _WithDrawFinishState();
}

class _WithDrawFinishState extends State<WithDrawFinish> {
  bool isSelected = false;

  CircleAvatar buildCircleAvatarCounter(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.red,
      child: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, state) {
          if (state is BasketLoaded) {
            return Text(
              "${state.items.length}",
              style: const TextStyle(color: Colors.white),
            );
          }
          return const Text("X", style: TextStyle(color: Colors.white));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(128),
        child: Column(
          children: [
            AppBar(
              title: const Text(""),
            ),
            BlocBuilder<BasketBloc, BasketState>(
              builder: (context, state) {
                if (state is BasketLoaded) {
                  return IconBtnWithCounter(
                    press: () {
                      _showMaterialDialog(state.items);
                    },
                    svgSrc: "images/cart.svg",
                    numOfitem: state.totalChartItems,
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoadSuccess) {
            if (state.products.isEmpty) {
              return const Center(
                child: Text("Aucun produit a partager"),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: 72,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return AccountWithdrawTile(
                  product: state.products[index],
                );
              },
            );
          }
          if (state is AccountLoadFailure) {
            return const Center(
              child: Text("Error"),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  int calculateBalance(List<Product> products) {
    print(">>>>>>${products[0].quantity}");
    double i = 0;
    for (var t in products) {
      i += t.quantity;
    }

    return i.ceil();
  }

  void _showMaterialDialog(List<Product> prod) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Confirmation info.",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Voulez-vous retirer ?",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${calculateBalance(prod)}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24,
                        ),
                      ),
                      SvgPicture.asset(
                        "images/wine.svg",
                        height: 48,
                        width: 32,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  const Spacer(),
                  ButtonBar(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () {},
                        child: const Text("Non"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 32,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Je confirme"),
                      ),
                    ],
                  )
                ],
              ),
            ),
            backgroundColor: Colors.white,
          );
        });
  }
}

class AccountWithdrawTile extends StatelessWidget {
  const AccountWithdrawTile({
    required this.product,
    Key? key,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBott(context, product);
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.only(top: 0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${product.quantity.ceil()}",
                    style: const TextStyle(fontSize: 32),
                  ),
                  SvgPicture.asset(
                    "images/wine.svg",
                    height: 42,
                    width: 40,
                  ),
                ],
              ),
              Text(
                " ${product.name}",
                style: const TextStyle(fontSize: 18),
              ),
              const Icon(CupertinoIcons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  showBott(BuildContext context, Product product) {
    double quantity = 3;
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => Container(
            padding: const EdgeInsets.only(bottom: 24),
            height: 250,
            color: Colors.white,
            child: Column(
              children: [
                Card(
                  color: Colors.blue[100],
                  child: ListTile(
                    title: Text(product.name),
                    leading: SvgPicture.asset(
                      "images/wine.svg",
                      height: 24,
                      width: 22,
                      color: Theme.of(context).primaryColor,
                    ),
                    trailing: Text(
                      quantity.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 72,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (quantity < 10) {
                              quantity++;
                            }
                          });
                        },
                        child: Container(
                          width: 72,
                          height: 48,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      /* Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text(
                          "$quantity",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 32,
                          ),
                        )),
                      ),*/

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
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.minus,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // if (_globalKey.currentState!.validate()) {
                          //   _globalKey.currentState!.save();
                          BlocProvider.of<BasketBloc>(context).add(
                            BasketItemAdded(
                              product.copyWith(quantity: quantity),
                            ),
                          );
                          Navigator.pop(context);
                          // }
                        },
                        child: const Text("Ajouter"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 15,
                          ),
                          primary: Colors.black,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
