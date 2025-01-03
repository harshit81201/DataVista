import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState {
  final List<Product> products;
  final ProductStatus status;
  final String? error;

  ProductState({
    this.products = const [],
    this.status = ProductStatus.initial,
    this.error,
  });

  ProductState copyWith({
    List<Product>? products,
    ProductStatus? status,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

abstract class ProductEvent {}
class LoadProducts extends ProductEvent {}
class SearchProducts extends ProductEvent {
  final String query;
  SearchProducts(this.query);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((json) => Product.fromJson(json)).toList();
        emit(state.copyWith(
          products: products,
          status: ProductStatus.success,
        ));
      } else {
        emit(state.copyWith(
          error: 'Failed to load products',
          status: ProductStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        status: ProductStatus.failure,
      ));
    }
  }

  Future<void> _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final filteredProducts = state.products
          .where((product) => 
              product.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(state.copyWith(
        products: filteredProducts,
        status: ProductStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        status: ProductStatus.failure,
      ));
    }
  }
}
