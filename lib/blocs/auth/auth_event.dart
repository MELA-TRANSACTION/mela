part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class StartAppEvent extends AuthEvent {}

class UpdateAuthState extends AuthEvent {
  final auth.User? user;

  const UpdateAuthState(this.user);

  @override
  List<Object> get props => [user!];
}

class Login extends AuthEvent {
  final String phone;
  final String password;

  const Login(this.phone, this.password);

  @override
  List<Object> get props => [phone, password];
}

class Register extends AuthEvent {
  final String name;
  final String phone;
  final String password;

  const Register(this.name, this.phone, this.password);
  @override
  List<Object> get props => [name, phone, password];
}

class Logout extends AuthEvent {}
