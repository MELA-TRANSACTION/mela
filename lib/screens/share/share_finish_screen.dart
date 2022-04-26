import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/account/account_bloc.dart';
import 'package:mela/blocs/basket/basket_bloc.dart';
import 'package:mela/models/product.dart';
import 'package:mela/screens/share/share_screen.dart';

class ShareFinishScreen extends StatefulWidget {
  const ShareFinishScreen({Key? key}) : super(key: key);

  @override
  State<ShareFinishScreen> createState() => _ShareFinishScreenState();
}

class _ShareFinishScreenState extends State<ShareFinishScreen> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste de produits"),
        actions: [],
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoadSuccess) {
            if (state.products.isEmpty) {
              return Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                  child: Text(
                    "Votre balance est vide, veillez vous recharger d'abord",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
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
                Product product = state.products[index];
                return ShareItem(
                  product: product,
                  onTap: () {
                    showBott(context, product);
                  },
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
      bottomNavigationBar: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoadSuccess) {
            if (state.products.isEmpty) {
              return Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                  child: const Text(
                    "Votre balance est vide veillez vous recharger d'abord",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          }
          return ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ShareScreen(products: []),
                ),
              );
            },
            child: const Text(
              "Je partage 4 Bouteiles",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              primary: Colors.blue[800],
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
            ),
          );
        },
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
                                product.copyWith(quantity: quantity)),
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

class ShareItem extends StatelessWidget {
  const ShareItem({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(top: 0.8),
      child: ListTile(
        leading: SvgPicture.asset(
          "images/beer1.svg",
          height: 44,
          width: 40,
        ),
        title: Text(product.name),
        subtitle: Text("${product.quantity} bouteils"),
        trailing: Checkbox(
          onChanged: (value) {},
          value: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
