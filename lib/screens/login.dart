import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context)..add(StartAppEvent()),
      listener: (context, state) {
        // if (state is AuthSuccess) {
        //   Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (context) => const AccountPage(),
        //     ),
        //     (route) => false,
        //   );
        // }
        // if (state is UnAuthenticated) {
        //   Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (context) => const LoginScreen(),
        //     ),
        //     (route) => false,
        //   );
        // }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Mela",
                      style: GoogleFonts.comfortaa(
                        fontSize: 64,
                        color: Colors.blue[700],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Mon wallet pour la biere",
                      style: GoogleFonts.comfortaa(
                        fontSize: 24,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "images/auth.png",
                          height: 56,
                          width: 40,
                        ),
                        Text(
                          "Continuer avec Google",
                          style: TextStyle(color: Colors.blue[700]),
                        ),
                      ],
                    ),
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
