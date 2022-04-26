import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/basket/basket_bloc.dart';
import 'package:mela/blocs/product/product_bloc.dart';
import 'package:mela/models/product.dart';
import 'package:mela/screens/recharge/recharge_basket_screen.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          children: [
            AppBar(
              title: const Text("Mes produits"),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if (state is BasketLoaded) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RechargeBasketScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade300,
                                border: Border.all(
                                  color: Colors.amber.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${state.items.length} items",
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Text(
                            "X items",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadSuccess) {
            if (state.products.isEmpty) {
              return const Center(
                child: Text("Pas des produits"),
              );
            }
            return ListView.builder(
                itemCount: state.products.length,
                padding: const EdgeInsets.only(
                  right: 8,
                  left: 8,
                  top: 16,
                  bottom: 120,
                ),
                itemBuilder: (context, index) {
                  Product product = state.products[index];
                  return ProductTile(
                    product: product,
                  );
                });
          }

          return const Center(
            child: Text("Loading ..."),
          );
        },
      ),
    );
  }
}

class ProductTile extends StatefulWidget {
  const ProductTile({
    required this.product,
    Key? key,
  }) : super(key: key);

  final Product product;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBott(context, widget.product);
      },
      child: Card(
        //color: Color(0xff0c2359),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: const Color(0xff0e2763),
        margin: const EdgeInsets.only(top: 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.product.quantity}",
                    style: TextStyle(color: Colors.amber[700], fontSize: 24),
                  ),
                  SizedBox(
                    width: 24,
                    child: SvgPicture.asset(
                      "images/wine.svg",
                      height: 24,
                      width: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.product.name} ",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                CupertinoIcons.chevron_right,
                color: Colors.white,
              ),
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
