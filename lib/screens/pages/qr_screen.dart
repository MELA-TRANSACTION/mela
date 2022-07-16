import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return PrettyQr(
                    //image: AssetImage('images/twitter.png'),
                    typeNumber: 3,
                    size: 200,
                    data: '${state.user.phone} ',
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                    roundEdges: true,
                  );
                }

                return const Center(
                  child: Text("En cours ..."),
                );
              },
            ),
            const SizedBox(
              height: 56,
            ),
            const Text(
              "Scanner ici pour recevoir un partage mela",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Fermer",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
