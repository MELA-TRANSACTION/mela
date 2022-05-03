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

class AddTransactionEvent extends TransEvent {
  final Product product;
  final String destinateur;

  const AddTransactionEvent({required this.product, required this.destinateur});

  @override
  List<Object> get props => [product, destinateur];
}
