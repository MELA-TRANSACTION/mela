import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mela/models/distributor.dart';
import 'package:mela/services/distributor_services.dart';

part 'distributors_event.dart';
part 'distributors_state.dart';

class DistributorsBloc extends Bloc<DistributorsEvent, DistributorsState> {
  final DistributorApi apiService;
  StreamSubscription? subscription;
  DistributorsBloc(this.apiService) : super(DistributorsInitial()) {
    on<DistributorsEvent>((event, emit) async {
      if (event is LoadDistributorsEvent) {
        emit(DistributorsLoadingState());
        try {
          subscription?.cancel();
          subscription = apiService.getDist().asStream().listen(
                (event) => add(UpdateDistributorsEvent(event)),
              );
        } catch (ex) {
          if (kDebugMode) {
            print(ex);
          }
          emit(DistributorsFailure());
        }
      }
      if (event is UpdateDistributorsEvent) {
        emit(DistributorsSuccess(event.distributors));
      }
    });
  }
}
