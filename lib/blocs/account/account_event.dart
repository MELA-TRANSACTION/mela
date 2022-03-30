part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class LoadAccountEvent extends AccountEvent {}

class UpdateAccountEvent extends AccountEvent {
  final Account account;

  const UpdateAccountEvent(this.account);

  @override
  List<Object> get props => [account];
}
