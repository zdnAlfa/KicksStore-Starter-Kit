import 'package:intl/intl.dart';

/// Model Data Produk Sepatu (Type-Safe Entity)
class ProductModel {
  final String id;
  final String name;
  final String category;
  final int price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String description;
  final bool isFavorite;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
  });

  /// Format harga ke mata uang Rupiah
  String get formattedPrice {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(price);
  }

  /// Membuat salinan objek dengan modifikasi parsial (Immutable state update)
  ProductModel copyWith({
    String? id,
    String? name,
    String? category,
    int? price,
    double? rating,
    int? reviewCount,
    String? imageUrl,
    String? description,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Konversi dari Map / JSON
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      category: map['category'] as String? ?? 'General',
      price: (map['price'] as num?)?.toInt() ?? 0,
      rating: (map['rating'] as num?)?.toDouble() ?? 5.0,
      reviewCount: (map['reviewCount'] as num?)?.toInt() ?? 0,
      imageUrl: map['imageUrl'] as String? ?? '',
      description: map['description'] as String? ?? '',
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }

  /// Konversi ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'imageUrl': imageUrl,
      'description': description,
      'isFavorite': isFavorite,
    };
  }
}