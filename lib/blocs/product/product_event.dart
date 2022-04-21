part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductEvent extends ProductEvent {}

class UpdateProductEvent extends ProductEvent {
  final List<Product> products;

  const UpdateProductEvent(this.products);

  @override
  List<Object> get props => [];
}
