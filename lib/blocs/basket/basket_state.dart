part of 'basket_bloc.dart';

@immutable
abstract class BasketState extends Equatable {
  const BasketState();
  @override
  List<Object> get props => [];
}

class BasketLoading extends BasketState {}

class BasketLoaded extends BasketState {
  final List<Product> items;

  const BasketLoaded({required this.items});

  int get totalChartItems => items.length;

  @override
  List<Object> get props => [items];
}

class BasketError extends BasketState {
  @override
  List<Object> get props => [];
}

class LoadCardState extends BasketState {
  final int index;

  const LoadCardState(this.index);
  @override
  List<Object> get props => [index];
}
