import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mela/models/user.dart';
import 'package:mela/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  StreamSubscription? subscription;
  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is StartAppEvent) {
        emit(AuthLoading());
        try {
          subscription?.cancel();
          subscription = authService
              .isLogin()
              .listen((event) => add(UpdateAuthState(event)));
        } catch (ex) {
          emit(UnAuthenticated());
        }
      }

      if (event is UpdateAuthState) {
        if (event.user != null) {
          var user = await authService.me();
          if (user == null) {
            print("error");
          } else {
            print(user.balance);
            emit(AuthSuccess(user));
          }
        } else {
          emit(UnAuthenticated());
        }
      }
      if (event is Login) {
        emit(AuthLoading());
        // await authService.signInWithGoogle();

        await authService.loginUser(
            phone: event.phone, password: event.password + "@mela");

        add(StartAppEvent());
      }
      if (event is Register) {
        emit(AuthLoading());
        // await authService.signInWithGoogle();
        await authService.registerUser(
            name: event.name,
            phone: event.phone,
            password: event.password,
            roles: ["client"]);
        // print(user.user!.uid);

        await authService.loginUser(
          phone: event.phone,
          password: event.password + "@mela",
        );

        add(StartAppEvent());
      }
      if (event is Logout) {
        emit(AuthLoading());
        await authService.logout();
        emit(UnAuthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
