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
  final Map<String, dynamic> data;

  const AddTransactionEvent(this.data);

  @override
  List<Object> get props => [data];
}
