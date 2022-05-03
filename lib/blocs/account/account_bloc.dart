import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mela/models/product.dart';
import 'package:mela/services/client_trans.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final TransClientService accountService;
  StreamSubscription? _subscription;
  AccountBloc({required this.accountService}) : super(AccountInitial()) {
    on<AccountEvent>((event, emit) async {
      if (event is LoadAccountEvent) {
        try {
          _subscription?.cancel();
          _subscription = accountService.getBalance().listen(
                (event) => add(UpdateAccountEvent(event)),
              );
        } catch (ex) {
          //print(ex);
          emit(AccountLoadFailure());
        }
      }
      if (event is UpdateAccountEvent) {
        emit(AccountLoadSuccess(products: event.products));
      }
      if (event is WithdrawProductEvent) {
        emit(AccountLoadingState());
        await accountService.withdrawBeer(event.product, event.destinateur);
        add(LoadAccountEvent());
      }
      if (event is ShareProductEvent) {
        emit(AccountLoadingState());
        await accountService.shareBeer(event.product, event.destinateur);
        add(LoadAccountEvent());
      }
    });
  }
}
