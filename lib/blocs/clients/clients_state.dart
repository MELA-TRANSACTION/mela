part of 'clients_bloc.dart';

abstract class ClientsState extends Equatable {
  const ClientsState();
  @override
  List<Object> get props => [];
}

class ClientsInitial extends ClientsState {
  @override
  List<Object> get props => [];
}

class ClientSearchSuccess extends ClientsState {
  final String clientId;

  const ClientSearchSuccess(this.clientId);
  @override
  List<Object> get props => [clientId];
}

class ClientSearchFailure extends ClientsState {}
