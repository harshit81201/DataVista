//import 'dart:convert';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final String? image;
  final String category;
  final double? rating;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.image,
    required this.category,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      category: json['category'],
      rating: json['rating']?['rate']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'rating': rating,
    };
  }

  @override
  List<Object?> get props => [id, title, description, price, image, category, rating];
}