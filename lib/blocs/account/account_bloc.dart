import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mela/models/account.dart';
import 'package:mela/services/account_service.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountService accountService;
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
          print(ex);
          emit(AccountLoadFailure());
        }
      }
      if (event is UpdateAccountEvent) {
        emit(AccountLoadSuccess(products: event.products));
      }
      if (event is WithdrawProductEvent) {
        emit(AccountLoadingState());
        await accountService.withDrawBeer(event.products, event.destinateur);
        add(LoadAccountEvent());
      }
      if (event is ShareProductEvent) {
        emit(AccountLoadingState());
        await accountService.shareBeer(event.products, event.destinateur);
        add(LoadAccountEvent());
      }
    });
  }
}
