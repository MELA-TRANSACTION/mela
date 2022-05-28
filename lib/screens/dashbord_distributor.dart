import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/models/trans.dart';
import 'package:mela/screens/recharge/list_product_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

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
                    CupertinoIcons.rocket,
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
                    BlocBuilder<TransBloc, TransState>(
                      builder: (context, state) {
                        if (state is TransStateSuccess) {
                          return Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            // textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "${calculateBalance(state.trans)} ",
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
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         fullscreenDialog: true,
                    //         builder: (context) => const AccountProductScreen(),
                    //       ),
                    //     );
                    //   },
                    //   child: const Text(
                    //     "voir plus",
                    //     style: TextStyle(color: Colors.amber),
                    //   ),
                    // ),
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
                top: 24,
                bottom: 120,
                right: 16,
                left: 16,
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

  int calculateBalance(List<Trans> trans) {
    //print(">>>>>>${products[0].quantity}");

    int n = 0;
    for (var t in trans) {
      if (t.status == "RECEIVE") {
        n = n + t.quantity;
      }
    }

    return n;
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
    timeago.setLocaleMessages('fr', timeago.FrMessages());
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
      child: ListTile(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${trans.quantity} ",
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
              "${trans.product.name} ",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        subtitle: Text(
          "${timeago.format(DateTime.fromMillisecondsSinceEpoch((trans.createdAt).ceil()), locale: 'fr')} ",
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Text(
          trans.status == "RECEIVE" ? "Recu" : "Envoyé",
          style: TextStyle(
            color: trans.status == "RECEIVE"
                ? const Color(0xff21CE99)
                : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {},
      ),
    );
  }

/*
 * Tests
 */

}
