part of 'distributors_bloc.dart';

abstract class DistributorsEvent extends Equatable {
  const DistributorsEvent();

  @override
  List<Object> get props => [];
}

class LoadDistributorsEvent extends DistributorsEvent {}

class UpdateDistributorsEvent extends DistributorsEvent {
  final List<Distributor> distributors;

  const UpdateDistributorsEvent(this.distributors);

  @override
  List<Object> get props => [distributors];
}

class SearchDistributorEvent extends DistributorsEvent {
  final String phone;

  const SearchDistributorEvent(this.phone);
  @override
  List<Object> get props => [phone];
}
