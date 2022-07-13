part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class UnAuthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthFailure extends AuthState {
  final AuthError authError;
  const AuthFailure(this.authError);
  @override
  List<Object> get props => [authError];

  @override
  String toString() {
    return 'AuthFailure{authError: ${authError.code} ====${authError.message}}';
  }
}
