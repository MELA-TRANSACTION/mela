import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mela/blocs/account/account_bloc.dart';
import 'package:mela/blocs/basket/basket_bloc.dart';
import 'package:mela/blocs/clients/clients_bloc.dart';
import 'package:mela/models/product.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  String destinateur = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partager avec"),
        leading: Icon(
          Icons.share,
          color: Colors.blue[900],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        children: [
          const SizedBox(
            height: 40,
          ),
          IntlPhoneField(
            onChanged: (v) => {
              setState(
                () {
                  destinateur = v.completeNumber;
                },
              )
            },
            initialCountryCode: "CD",
            showCountryFlag: false,
            style: const TextStyle(
              color: Colors.white,
            ),
            dropdownTextStyle: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: const Text("Destinateur"),
              suffixIcon: TextButton(
                onPressed: () {
                  BlocProvider.of<ClientsBloc>(context)
                      .add(LoadClientSearch(destinateur));
                },
                child: const Text("Search"),
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: Icon(
                  Icons.phone_iphone_rounded,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 72),
                child: Text(
                  "Entrer le numero de votre destinateur",
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
          const SizedBox(
            height: 72,
          ),
          BlocBuilder<BasketBloc, BasketState>(
            builder: (context, state) {
              if (state is BasketLoaded) {
                return ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AccountBloc>(context).add(ShareProductEvent(
                        products: state.items, destinateur: destinateur));
                  },
                  child: const Text("Terminer"),
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                    primary: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
              return ElevatedButton(
                onPressed: () {},
                child: const Text("Loading ..."),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  primary: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  showConfirmBott(BuildContext context, List<Product> products) {
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
                          BlocProvider.of<AccountBloc>(context).add(
                            ShareProductEvent(
                              products: products,
                              destinateur: destinateur,
                            ),
                          );
                          Navigator.pop(context);
                          // }
                        },
                        child: const Text("Confirmer"),
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
