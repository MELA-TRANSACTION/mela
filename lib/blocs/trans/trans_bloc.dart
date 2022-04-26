import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/trans.dart';
import 'package:mela/services/trans_service.dart';

part 'trans_event.dart';
part 'trans_state.dart';

class TransBloc extends Bloc<TransEvent, TransState> {
  final TransService transService;
  StreamSubscription? _subscription;
  TransBloc(this.transService) : super(TransInitial()) {
    on<TransEvent>((event, emit) async {
      if (event is LoadTransEvent) {
        try {
          _subscription?.cancel();
          _subscription = transService
              .getTrans()
              .listen((event) => add(UpdateTransEvent(event)));
        } catch (ex) {
          emit(TransStateFailure());
        }
      }
      if (event is UpdateTransEvent) {
        emit(TransStateSuccess(event.trans));
      }
      if (event is AddTransactionEvent) {
        await transService.addTrans(event.products, event.destinateur);
      }
    });
  }
}
