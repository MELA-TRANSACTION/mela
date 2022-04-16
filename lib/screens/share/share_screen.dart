import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/account/account_bloc.dart';
import 'package:mela/blocs/clients/clients_bloc.dart';
import 'package:mela/models/account.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key, required this.products}) : super(key: key);
  final List<Product> products;

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
          TextFormField(
            onChanged: (v) => {
              setState(
                () {
                  destinateur = v;
                },
              )
            },
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
                  )),
              fillColor: Colors.white,
              filled: true,
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
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AccountBloc>(context).add(ShareProductEvent(
                  products: [...widget.products], destinateur: destinateur));
            },
            child: const Text("Terminer"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              primary: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
