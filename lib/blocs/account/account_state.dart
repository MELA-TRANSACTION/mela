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
  final Account account;

  const AccountLoadSuccess({required this.account});
}

class AccountLoadFailure extends AccountState {}
