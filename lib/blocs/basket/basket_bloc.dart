import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mela/models/basket.dart';
import 'package:mela/models/product.dart';
import 'package:meta/meta.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final Basket basket;
  StreamSubscription? subscription;
  BasketBloc(this.basket) : super(BasketLoading()) {
    on<BasketEvent>((event, emit) {
      if (event is BasketStarted) {
        emit(BasketLoading());
        try {
          subscription?.cancel();
          subscription = basket
              .returnCartList()
              .listen((event) => add(UpdateBasket(event)));
        } catch (e) {
          emit(BasketError());
        }
      }
      if (event is BasketItemAdded) {
        //print(event.basketItem.name);
        basket.addToCart(event.basketItem);
        add(BasketStarted());
        subscription =
            basket.returnCartList().listen((event) => add(UpdateBasket(event)));
      }
      if (event is UpdateBasket) {
        emit(BasketLoaded(items: event.items));
      }

      if (event is InitBasketEvent) {
        basket.initBasket();
        add(BasketStarted());
      }
      if (event is BasketItemDeleted) {
        print("deleted");
        basket.deleteItem(event.item);
        add(BasketStarted());
        emit(BasketLoading());
        subscription =
            basket.returnCartList().listen((event) => add(UpdateBasket(event)));
      }
    });
  }
}
