part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadSuccess extends ProductState {
  final List<Product> products;

  const ProductLoadSuccess({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductLoadFailure extends ProductState {}
