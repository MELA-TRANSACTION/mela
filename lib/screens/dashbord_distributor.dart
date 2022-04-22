import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/trans.dart';
import 'package:mela/screens/recharge/list_product_screen.dart';
import 'package:mela/screens/recharge/recharge_basket_screen.dart';

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
                /* OutlinedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(Logout());
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),*/
              ],
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      // textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text(
                          "490",
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
                    ),
                    const Text(
                      "voir plus",
                      style: TextStyle(color: Colors.amber),
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
                  right: 1.8,
                  left: 1.8,
                ),
                itemBuilder: (context, int index) {
                  Trans trans = state.trans[index];
                  return TransTile(trans: trans);
                });
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
}

class TransTile extends StatelessWidget {
  const TransTile({
    required this.trans,
    Key? key,
  }) : super(key: key);

  final Trans trans;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  "${nFormatter(trans.quantity)} ",
                  style: const TextStyle(color: Colors.white, fontSize: 24),
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
                Text(
                  "${trans.products.name} ",
                  style: const TextStyle(color: Colors.white, fontSize: 8),
                ),
              ],
            ),
            const SizedBox(
              width: 56,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trans.distributor!.name,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  trans.distributor!.phone,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.arrow_turn_left_down,
              color: trans.type == "Recharge_beer"
                  ? const Color(0xff21ce99)
                  : Colors.amber[800],
            )
          ],
        ),
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

/*
 * Tests
 */

}
