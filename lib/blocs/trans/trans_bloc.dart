import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/trans_mela.dart';
import 'package:mela/services/trans_service.dart';

part 'trans_event.dart';
part 'trans_state.dart';

class TransBloc extends Bloc<TransEvent, TransState> {
  final TransService transService;
  StreamSubscription? _subscription;
  TransBloc(this.transService) : super(TransInitial()) {
    on<TransEvent>((event, emit) async {
      if (event is LoadTransEvent) {
        emit(TransLoading());
        try {
          _subscription?.cancel();
          _subscription = transService.getTrans().asStream().listen(
                (event) => add(
                  UpdateTransEvent(event),
                ),
              );
        } catch (ex) {
          emit(TransStateFailure());
        }
      }
      if (event is UpdateTransEvent) {
        emit(TransStateSuccess(event.trans));
      }
      if (event is AddRechargeEvent) {
        emit(TransLoading());
        await transService.recharge({
          "receiverId": event.destinateur,
          "productId": event.product,
          "quantity": event.quantity,
          "cost": 0,
        });
        add(LoadTransEvent());
      }

      if (event is AddWithdrawEvent) {
        emit(TransLoading());
        await transService.withdrawFrom({
          "receiverId": event.destinateur,
          "productId": event.product,
          "quantity": event.quantity,
          "cost": 0,
        });
        add(LoadTransEvent());
      }
      if (event is AddShareEvent) {
        emit(TransLoading());
        await transService.shareWith({
          "receiverId": event.destinateur,
          "productId": event.product,
          "quantity": event.quantity,
          "cost": 0,
        });
        add(LoadTransEvent());
      }
    });
  }
}
