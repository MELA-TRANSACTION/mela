import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/blocs/account/account_bloc.dart';
import 'package:mela/models/account.dart';

class WithDrawFinish extends StatefulWidget {
  const WithDrawFinish({Key? key, required this.distributor}) : super(key: key);
  final String distributor;

  @override
  State<WithDrawFinish> createState() => _WithDrawFinishState();
}

class _WithDrawFinishState extends State<WithDrawFinish> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: CheckboxListTile(
              onChanged: (v) {},
              value: isSelected,
              title: const Text("Cocher tout"),
            ),
          )
        ],
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoadSuccess) {
            if (state.products.isEmpty) {
              return const Center(
                child: Text("Aucun produit a partager"),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: 72,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return AccountWithdrawTile(
                  product: state.products[index],
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
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          BlocProvider.of<AccountBloc>(context).add(WithdrawProductEvent(
              products: [], destinateur: widget.distributor));
        },
        child: const Text(
          "Je retire 4 B",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
          primary: Colors.blue[800],
          padding: const EdgeInsets.symmetric(
            vertical: 18,
          ),
        ),
      ),
    );
  }
}

class AccountWithdrawTile extends StatelessWidget {
  const AccountWithdrawTile({
    required this.product,
    Key? key,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(top: 0.8),
      child: ListTile(
        leading: SvgPicture.asset(
          "images/wine.svg",
          height: 44,
          width: 40,
        ),
        title: Text("${product.quantity} ${product.name}"),
        subtitle: Text(product.format),
        trailing: Checkbox(
          onChanged: (value) {},
          value: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
