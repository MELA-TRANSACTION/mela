import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';
import 'package:mela/blocs/product/product_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/trans.dart';
import 'package:mela/screens/account_product_screen.dart';
import 'package:mela/screens/recharge/list_product_screen.dart';

class DashboardDistributor extends StatefulWidget {
  const DashboardDistributor({Key? key}) : super(key: key);

  @override
  _DashboardDistributorState createState() => _DashboardDistributorState();
}

class _DashboardDistributorState extends State<DashboardDistributor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff92b2fc),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              title: const Text(
                "Mela-business",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(Logout());
                  },
                  icon: const Icon(
                    CupertinoIcons.bell,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoadSuccess) {
                          return Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            // textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "${calculateBalance(state.products)} ",
                                style: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
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
                          );
                        }

                        return Row(
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          // textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text(
                              "xxx",
                              style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
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
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const AccountProductScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "voir plus",
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: BlocBuilder<TransBloc, TransState>(
        builder: (context, state) {
          if (state is TransStateSuccess) {
            if (state.trans.isEmpty) {
              return const Center(
                child: Text("aucun trans"),
              );
            }
            return ListView.builder(
              itemCount: state.trans.length,
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 120,
                right: 10,
                left: 10,
              ),
              itemBuilder: (context, int index) {
                Trans trans = state.trans[index];
                return TransTile(trans: trans);
              },
            );
          }
          if (state is TransStateFailure) {
            return const Center(
              child: Text("une erreur"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        extendedPadding: const EdgeInsets.symmetric(horizontal: 48),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ListProductScreen(),
            ),
          );
        },
        label: const Text(
          "Recharger client",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        // backgroundColor: Colors.amber[600],
        backgroundColor: const Color(0xff21CE99),
        icon: SvgPicture.asset(
          "images/wine.svg",
          height: 24,
          width: 22,
          color: Colors.black,
        ),
      ),
    );
  }

  int calculateBalance(List<Product> products) {
    //print(">>>>>>${products[0].quantity}");
    double i = 0;
    for (var t in products) {
      i += t.quantity;
    }

    return i.ceil();
  }

  String nFormatter(numb) {
    var t = 0.0;
    if (numb >= 1000000000) {
      t = (numb / 1000000000);

      return '$t G';
    }
    if (numb >= 1000000) {
      t = (numb / 1000000);

      return '$t M';
    }
    if (numb >= 1000) {
      t = (numb / 1000);

      return '$t K';
    }
    return numb.toString();
  }
}

class TransTile extends StatelessWidget {
  const TransTile({
    required this.trans,
    Key? key,
  }) : super(key: key);

  final Trans trans;

  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return Card(
      //color: Color(0xff0c2359),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      margin: const EdgeInsets.only(
        top: 1,
      ),

      // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        height: 78,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${trans.products.quantity.ceil()} ",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: 24,
                  child: SvgPicture.asset(
                    "images/wine.svg",
                    height: 24,
                    width: 22,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "${trans.products.name} ",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 56,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trans.sender!.name,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  child: Text(
                    ' à ',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Text(
                  trans.receiver!.name,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              trans.sender!.uid != uid
                  ? CupertinoIcons.arrow_turn_left_down
                  : CupertinoIcons.arrow_turn_right_up,
              color: trans.sender!.uid != uid
                  ? const Color(0xff21ce99)
                  : Colors.amber[800],
            )
          ],
        ),
      ),
    );
  }

/*
 * Tests
 */

}
