part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class StartAppEvent extends AuthEvent {}

class UpdateAuthState extends AuthEvent {
  final User? user;

  const UpdateAuthState(this.user);

  @override
  List<Object> get props => [user!];
}

class Login extends AuthEvent {}

class Logout extends AuthEvent {}
