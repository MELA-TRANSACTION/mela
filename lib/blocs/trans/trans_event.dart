part of 'trans_bloc.dart';

abstract class TransEvent extends Equatable {
  const TransEvent();

  @override
  List<Object> get props => [];
}

class LoadTransEvent extends TransEvent {}

class UpdateTransEvent extends TransEvent {
  final List<Trans> trans;

  const UpdateTransEvent(this.trans);

  @override
  List<Object> get props => [trans];
}

class AddRechargeEvent extends TransEvent {
  final Product product;
  final String destinateur;
  final int quantity;

  const AddRechargeEvent(
      {required this.product,
      required this.quantity,
      required this.destinateur});

  @override
  List<Object> get props => [product, destinateur, quantity];
}

class AddWithdrawEvent extends TransEvent {
  final String destinateur;
  final num amount;

  const AddWithdrawEvent({required this.amount, required this.destinateur});

  @override
  List<Object> get props => [
        amount,
        destinateur,
      ];
}

class AddShareEvent extends TransEvent {
  final String destinateur;
  final num amount;

  const AddShareEvent({required this.amount, required this.destinateur});

  @override
  List<Object> get props => [
        destinateur,
      ];
}
