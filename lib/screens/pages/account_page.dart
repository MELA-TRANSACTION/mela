import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/account/account_bloc.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';
import 'package:mela/blocs/product/product_bloc.dart';
import 'package:mela/components/product_tile.dart';
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
            const BalanceWidget(),
          ],
        ),
      ),

      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadSuccess) {
            if (state.products.isEmpty) {
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
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductTile(
                  product: state.products[index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ShareScreen(
                          product: state.products[index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          if (state is ProductLoadFailure) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DistributorScreen(),
            ),
          );
        },
        tooltip: "Distributors",
        backgroundColor: Colors.amber[600],
        child: const Icon(
          CupertinoIcons.location,
          color: Colors.black,
        ),
      ),
    );
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: MediaQuery.of(context).size.height * 0.17,
      //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              SvgPicture.asset(
                "images/wine.svg",
                height: 28,
                color: Colors.black,
              ),
              const Text(
                " Beers",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const AccountProductScreen(),
                  ),
                );
              },
              child: Text(
                'Vous pouvez aussi parier',
                style: TextStyle(color: Colors.white),
              ),
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
