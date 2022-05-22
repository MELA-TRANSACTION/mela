import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/models/product.dart';
import 'package:pinput/pinput.dart';

class ShareFinishScreen extends StatefulWidget {
  const ShareFinishScreen({
    Key? key,
    required this.product,
    required this.receiver,
    required this.typeTrans,
    required this.quantity,
  }) : super(key: key);
  final Product product;
  final int quantity;
  final String receiver;
  final String typeTrans;

  @override
  State<ShareFinishScreen> createState() => _ShareFinishScreenState();
}

class _ShareFinishScreenState extends State<ShareFinishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmation"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.48,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white70,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              "Voulez-vous ${widget.typeTrans} ",
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "  ${widget.product.name} au pres de ",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.receiver} ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Entrer votre pin",
              style: TextStyle(
                fontSize: 18,
                color: Colors.orange,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Pinput(
              onCompleted: (pin) => print(pin),
              closeKeyboardWhenCompleted: true,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              ),
              onPressed: () {
                if (widget.typeTrans == "Partager") {
                  BlocProvider.of<TransBloc>(context).add(
                    AddShareEvent(
                      product: widget.product.name,
                      destinateur: widget.receiver,
                      quantity: widget.quantity,
                    ),
                  );
                } else {
                  BlocProvider.of<TransBloc>(context).add(
                    AddWithdrawEvent(
                      product: widget.product.id,
                      destinateur: widget.receiver,
                      quantity: widget.quantity,
                    ),
                  );
                }
              },
              child: const Text("Je confirme"),
            )
          ],
        ),
      ),
    );
  }
}
