part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class LoadAccountEvent extends AccountEvent {}

class UpdateAccountEvent extends AccountEvent {
  final List<Product> products;

  const UpdateAccountEvent(this.products);

  @override
  List<Object> get props => [products];
}

class ShareProductEvent extends AccountEvent {
  final List<Product> products;
  final String destinateur;
  const ShareProductEvent({
    required this.products,
    required this.destinateur,
  });
}

class WithdrawProductEvent extends AccountEvent {
  final List<Product> products;
  final String destinateur;

  const WithdrawProductEvent({
    required this.products,
    required this.destinateur,
  });
}
