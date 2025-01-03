import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
//import '../models/product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.status == ProductStatus.failure) {
          return Center(child: Text(state.error ?? 'Error loading products'));
        }
        return ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            final product = state.products[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
                trailing: Text('Rating: ${product.rating ?? 'N/A'}'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product: product),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}