import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/components/product_tile.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/trans.dart';
import 'package:mela/screens/account_product_screen.dart';
import 'package:mela/screens/distributorScreen.dart';
import 'package:mela/screens/share/share_screen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(106),
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              title: const Text(
                "Balance",
                // style: TextStyle(
                //   fontWeight: FontWeight.w400,
                //   fontSize: 15,
                // ),
              ),
              actions: [
                const Icon(
                  CupertinoIcons.bell,
                ),
                OutlinedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(Logout());
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                  ),
                  child: const Icon(
                    Icons.outbond_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            BlocBuilder<TransBloc, TransState>(
              builder: (context, state) {
                if (state is TransStateSuccess) {
                  var prods = getProductFromTrans(state.trans);
                  var balance = getMyBalances(prods);

                  return BalanceWidget(
                    balance: balance,
                  );
                }
                return const Center(
                  child: Text("loading ..."),
                );
              },
            ),
          ],
        ),
      ),

      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            if (state.user.balance!.isEmpty) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white70,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                height: 250,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "images/wine.svg",
                      height: 64,
                      width: 48,
                      color: Colors.white70,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Vous n'avez aucune Bouteille",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DistributorScreen(),
                          ),
                        );
                      },
                      child: const Text("Veillez Reserver"),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      )),
                    )
                    //ElevatedButton(onPressed: (){}, child: Text("Veillez Reserver"))
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: state.user.balance!.length,
              padding: const EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                var product = state.user.balance![index];
                print(product.quantity);
                return ProductTile(
                  product: product,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ShareScreen(
                          product: product,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          if (state is UnAuthenticated) {
            return const Center(
              child: Text("Error "),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DistributorScreen(),
            ),
          );
        },
        tooltip: "Distributors",
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.amber[600],
        label: const Text(
          "Nos ditributeurs",
          style: TextStyle(color: Colors.black),
        ),
        icon: const Icon(
          CupertinoIcons.location,
          color: Colors.black,
        ),
      ),
    );
  }

  List<Product> getProductFromTrans(List<Trans> trans) {
    List<Product> products = [];
    for (var t in trans) {
      var product = Product(
        id: t.product.id,
        name: t.product.name,
        format: t.product.format,
        price: t.product.price,
        quantity: t.quantity,
        ref: t.id,
        typeTrans: t.status,
      );

      products.add(
        product,
      );
    }

    return products;
  }

  int getMyBalances(List<Product> products) {
    int balance = 0;
    for (var prod in products) {
      if (prod.typeTrans == "SEND") {
        balance = balance - prod.quantity!.ceil();
      } else {
        balance = balance + prod.quantity!.ceil();
      }
    }

    return balance;
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    Key? key,
    required this.balance,
  }) : super(key: key);

  final int balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: MediaQuery.of(context).size.height * 0.17,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      //margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        //color: Theme.of(context).colorScheme.secondary,
        color: const Color(0xff21CE99),
        //borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xff21CE99),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            "$balance",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          SvgPicture.asset(
            "images/wine.svg",
            height: 28,
            color: Colors.white,
          ),
          const Text(
            " Beers",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginAction extends StatelessWidget {
  const LoginAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.amber,
            ),
            child: Center(
              child: SvgPicture.asset(
                "images/user.svg",
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          const Text(
            "Connectez-vous",
            style: TextStyle(
              fontSize: 18,
              color: Colors.amber,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
