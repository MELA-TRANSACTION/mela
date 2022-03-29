import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';
import 'package:mela/screens/pages/account_page.dart';
import 'package:mela/screens/welcome_screen.dart';
import 'package:mela/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return BlocProvider(
      create: (context) => AuthBloc(authService: AuthService())
        ..add(
          StartAppEvent(),
        ),
      child: MaterialApp(
        title: 'Mela app for happy',
        localizationsDelegates: [
          // Creates an instance of FirebaseUILocalizationDelegate with overridden labels
          // FlutterFireUILocalizations.withDefaultOverrides(
          // const LabelOverrides()),

          // Delegates below take care of built-in flutter widgets
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,

          // This delegate is required to provide the labels that are not overridden by LabelOverrides
          FlutterFireUILocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            secondary: const Color(0xff0e2763),
          ),
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.blueGrey[50],
          appBarTheme: const AppBarTheme(
            elevation: 0.9,
            color: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          //bloc: AuthBloc(authService: AuthService())..add(StartAppEvent()),
          builder: (context, state) {
            if (state is UnAuthenticated) {
              return const WelcomeScreen();
            }
            if (state is AuthSuccess) {
              //print(state.user);
              return const AccountPage();
            }

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
