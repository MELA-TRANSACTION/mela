import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/account/account_bloc.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';
import 'package:mela/screens/account_product_screen.dart';
import 'package:mela/screens/distributorScreen.dart';
import 'package:mela/screens/share/share_finish_screen.dart';
import 'package:mela/screens/withdraw/withdraw_screen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Balance",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bell,
              color: Colors.deepPurpleAccent,
            ),
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
            child: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // const LoginAction(),
          const BalanceWidget(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ShareFinishScreen(),
                    ),
                  );
                },
                label: "Partager avec",
                imageUrl: "images/wine.svg",
                bgColor: Colors.blue[900],
              ),
              ActionButton(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WithdrawScreen(),
                    ),
                  );
                },
                label: "Retirer",
                imageUrl: "images/wine2.svg",
                bgColor: Colors.blue[900],
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        extendedPadding: const EdgeInsets.symmetric(horizontal: 48),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DistributorScreen(),
            ),
          );
        },
        label: const Text(
          "Nos distributeurs",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amber[600],
        icon: const Icon(
          CupertinoIcons.location,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.label,
    required this.onTap,
    required this.imageUrl,
    this.bgColor,
    Key? key,
  }) : super(key: key);
  final String imageUrl;
  final String label;
  final Color? bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 180,
        width: 140,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imageUrl,
              height: 40,
              color: Colors.white,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              label,
              style: TextStyle(
                color: bgColor != null ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Icon(
              CupertinoIcons.chevron_compact_down,
              color: Colors.white,
            )
          ],
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
      height: MediaQuery.of(context).size.height * 0.22,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      //margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        //color: Theme.of(context).colorScheme.secondary,
        color: Colors.white,
        //borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoadSuccess) {
            var products = state.products;

            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "${products.length}",
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[900],
                      ),
                    ),
                    SvgPicture.asset("images/wine.svg", height: 52),
                    const Text(
                      " Bouteilles",
                      style: TextStyle(
                        fontSize: 24,
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
                      'Voir plus',
                      style: TextStyle(color: Colors.blue[600]),
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is AccountLoadFailure) {
            return const Center(
              child: Text("Error"),
            );
          }

          return const Center(
            child: Text("Loading ..."),
          );
        },
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
