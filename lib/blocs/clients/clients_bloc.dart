import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mela/services/api_service.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {
  final ApiService apiService;
  ClientsBloc(this.apiService) : super(ClientsInitial()) {
    on<ClientsEvent>((event, emit) async {
      if (event is LoadClientSearch) {
        try {
          var t = await apiService.getDestinateur(event.phone);
          emit(ClientSearchSuccess(t));
        } catch (ex) {
          emit(ClientSearchFailure());
        }
      }
    });
  }
}
