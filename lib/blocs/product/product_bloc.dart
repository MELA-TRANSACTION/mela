import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mela/models/product.dart';
import 'package:mela/services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  StreamSubscription? _subscription;
  ProductBloc(this.productService) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      if (event is LoadProductEvent) {
        try {
          _subscription?.cancel();
          _subscription = productService.getProducts().listen((event) {
            add(
              UpdateProductEvent(event),
            );
          });
        } catch (ex) {
          print(ex);
          emit(ProductLoadFailure());
        }
      }
      if (event is UpdateProductEvent) {
        emit(ProductLoadSuccess(products: event.products));
      }
    });
  }
}
