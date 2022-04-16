part of 'distributors_bloc.dart';

abstract class DistributorsState extends Equatable {
  const DistributorsState();
  @override
  List<Object> get props => [];
}

class DistributorsInitial extends DistributorsState {
  @override
  List<Object> get props => [];
}

class DistributorsSuccess extends DistributorsState {
  final List<Distributor> distributors;

  const DistributorsSuccess(this.distributors);

  @override
  List<Object> get props => [distributors];
}

class DistributorsFailure extends DistributorsState {}

class DistributorsLoadingState extends DistributorsState {}

class DistributorSearchSuccess extends DistributorsState {
  final String distributor;

  const DistributorSearchSuccess(this.distributor);
}
