import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.grey[200],
              child: Icon(
                CupertinoIcons.person,
                size: 40,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  var user = state.user;
                  return Column(
                    children: [
                      Text(
                        "${user.name} ",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        "${user.phone} ",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 72,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Changer mon mot de passe",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Deconnexion",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Supprimer mon compte",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "Avertissement: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text:
                        "L'abus de l'alcool est dangereux pour la santé, à consomer avec moderation."
                        " La consommation d'alcool est vivement deconseillée aux femmes enceintes."
                        " La vente d'alcool est interdit aux mineurs de moins de 18 ans."
                        " En accedant en nos offres vous accepter que vous avez 18 ans revolue.",
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "@2022 mela-tech , Tous droits reservés",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
