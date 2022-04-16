part of 'clients_bloc.dart';

abstract class ClientsEvent extends Equatable {
  const ClientsEvent();

  @override
  List<Object> get props => [];
}

class LoadClientSearch extends ClientsEvent {
  final String phone;

  const LoadClientSearch(this.phone);

  @override
  List<Object> get props => [phone];
}
