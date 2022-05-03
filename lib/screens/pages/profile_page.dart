import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            const CircleAvatar(
              radius: 56,
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccessClient) {
                  var user = state.user;
                  return Column(
                    children: [
                      Text(
                        "${user.name} ",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        "${user.phone} ",
                        style: const TextStyle(
                          color: Colors.white,
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
              height: 16,
            ),
            const Card(
              child: ListTile(
                title: Text("Modifier mon pin"),
                leading: Icon(CupertinoIcons.lock),
                trailing: Icon(CupertinoIcons.chevron_right),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text("Deconnexion"),
                leading: Icon(CupertinoIcons.share),
                trailing: Icon(CupertinoIcons.chevron_right),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text(
                  "Effacer mon compte",
                ),
                leading: Icon(CupertinoIcons.delete),
                trailing: Icon(CupertinoIcons.chevron_right),
              ),
            )
          ]),
        ));
  }
}
