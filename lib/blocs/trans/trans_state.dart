part of 'trans_bloc.dart';

abstract class TransState extends Equatable {
  const TransState();
  @override
  List<Object> get props => [];
}

class TransInitial extends TransState {}

class TransLoading extends TransState {}

class TransStateSuccess extends TransState {
  final List<Trans> trans;

  const TransStateSuccess(this.trans);

  @override
  List<Object> get props => [trans];
}

class TransStateFailure extends TransState {}
