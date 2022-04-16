import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mela/models/distributor.dart';
import 'package:mela/services/api_service.dart';

part 'distributors_event.dart';
part 'distributors_state.dart';

class DistributorsBloc extends Bloc<DistributorsEvent, DistributorsState> {
  final ApiService apiService;
  StreamSubscription? subscription;
  DistributorsBloc(this.apiService) : super(DistributorsInitial()) {
    on<DistributorsEvent>((event, emit) async {
      if (event is LoadDistributorsEvent) {
        emit(DistributorsLoadingState());
        try {
          subscription?.cancel();
          subscription = apiService.getDistributors().listen(
                (event) => add(UpdateDistributorsEvent(event)),
              );
        } catch (ex) {
          emit(DistributorsFailure());
        }
      }
      if (event is UpdateDistributorsEvent) {
        emit(DistributorsSuccess(event.distributors));
      }

      if (event is SearchDistributorEvent) {
        emit(DistributorsLoadingState());
        String t = await apiService.getDistributor(event.phone);
        emit(DistributorSearchSuccess(t));
      }
    });
  }
}
