import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/account/account_bloc.dart';
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
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.only(top: 0.8),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      "images/beer1.svg",
                      height: 44,
                      width: 40,
                    ),
                    title: const Text("Doppel"),
                    subtitle: const Text("2 bouteils"),
                    trailing: Checkbox(
                      onChanged: (value) {},
                      value: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
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
}
