part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountLoadSuccess extends AccountState {
  final List<Product> products;

  const AccountLoadSuccess({required this.products});

  @override
  List<Object> get props => [products];
}

class AccountLoadFailure extends AccountState {}

class AccountLoadingState extends AccountState {}
