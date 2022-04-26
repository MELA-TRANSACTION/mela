part of 'basket_bloc.dart';

@immutable
abstract class BasketEvent extends Equatable {
  const BasketEvent();
  @override
  List<Object> get props => [];
}

class BasketStarted extends BasketEvent {}

class BasketItemAdded extends BasketEvent {
  final Product basketItem;

  const BasketItemAdded(this.basketItem);

  @override
  List<Object> get props => [basketItem];
}

class InitBasketEvent extends BasketEvent {}

class BasketItemDeleted extends BasketEvent {
  final Product item;

  const BasketItemDeleted(this.item);

  @override
  List<Object> get props => [item];
}

class UpdateBasket extends BasketEvent {
  final List<Product> items;

  const UpdateBasket(this.items);
  @override
  List<Object> get props => [items];
}
