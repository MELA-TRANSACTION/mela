import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mela/blocs/auth/auth_bloc.dart';

import 'package:mela/blocs/distrib/distributors_bloc.dart';
import 'package:mela/blocs/trans/trans_bloc.dart';

import 'package:mela/screens/dashbord_distributor.dart';
import 'package:mela/screens/main_page.dart';
import 'package:mela/screens/welcome_screen.dart';
import 'package:mela/services/auth_service.dart';
import 'package:mela/services/distributor_services.dart';

import 'package:mela/services/trans_service.dart';

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DistributorsBloc(DistributorApi())
              ..add(
                LoadDistributorsEvent(),
              ),
          ),
          BlocProvider(
            create: (context) => TransBloc(TransService())
              ..add(
                LoadTransEvent(),
              ),
          ),
        ],
        child: MaterialApp(
          title: 'Mela app for happy',
          debugShowCheckedModeBanner: false,
          theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              secondary: Colors.amber[800],
            ),
            primaryColor: const Color(0xff0e2763),
            scaffoldBackgroundColor: const Color(0xff0c2359),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              hintStyle: const TextStyle(color: Colors.white70),
              labelStyle: const TextStyle(color: Colors.white),
              prefixIconColor: Colors.white,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0.9,
              color: Color(0xff0e2763),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              systemOverlayStyle: SystemUiOverlayStyle.light,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),
            brightness: Brightness.dark,
          ),
          home: BlocBuilder<AuthBloc, AuthState>(
            //bloc: AuthBloc(authService: AuthService())..add(StartAppEvent()),
            builder: (context, state) {
              if (state is UnAuthenticated) {
                return const WelcomeScreen();
              }
              if (state is AuthSuccessClient) {
                //print(state.user);
                return const MainPage();
              }

              if (state is AuthSuccessDistributor) {
                return const DashboardDistributor();
              }

              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
