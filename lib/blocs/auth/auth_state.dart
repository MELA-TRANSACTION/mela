part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class UnAuthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccessClient extends AuthState {
  final User user;

  const AuthSuccessClient(this.user);

  @override
  List<Object> get props => [user];
}

class AuthSuccessDistributor extends AuthState {
  final User user;

  const AuthSuccessDistributor(this.user);

  @override
  List<Object> get props => [user];
}
