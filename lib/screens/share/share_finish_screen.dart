import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';
import 'package:mela/models/product.dart';
import 'package:mela/screens/main_page.dart';
import 'package:mela/services/api_service.dart';

class ShareFinishScreen extends StatefulWidget {
  const ShareFinishScreen({
    Key? key,
    required this.receiver,
    required this.typeTrans,
    required this.amount,
  }) : super(key: key);

  final num amount;
  final String receiver;
  final String typeTrans;

  @override
  State<ShareFinishScreen> createState() => _ShareFinishScreenState();
}

class _ShareFinishScreenState extends State<ShareFinishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            Text(
              "Voulez-vous ${widget.typeTrans} ",
              style: const TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "  ${widget.amount.ceil()} CDF avec le ",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.receiver} ",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            buildAuthenticate(context),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Confirmer',
        icon: Icons.lock_open,
        onClicked: () async {
          await LocalAuthApi.hasBiometrics();
          final biometrics = await LocalAuthApi.getBiometrics();

          biometrics.contains(BiometricType.fingerprint);

          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            if (widget.typeTrans == "Partager") {
              BlocProvider.of<TransBloc>(context).add(
                AddShareEvent(
                  destinateur: widget.receiver,
                  amount: widget.amount,
                ),
              );
            } else {
              BlocProvider.of<TransBloc>(context).add(
                AddWithdrawEvent(
                  destinateur: widget.receiver,
                  amount: widget.amount,
                ),
              );
            }
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
          }
        },
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}
