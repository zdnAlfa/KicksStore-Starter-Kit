import 'package:intl/intl.dart';
import 'product_model.dart';

/// Model Item Keranjang Belanja
class CartItemModel {
  final String id;
  final ProductModel product;
  final String selectedSize;
  int quantity;

  CartItemModel({
    required this.id,
    required this.product,
    required this.selectedSize,
    this.quantity = 1,
  });

  /// Total harga untuk item ini (Harga Satuan x Jumlah)
  int get subtotal => product.price * quantity;

  /// Format harga total per item ke Rupiah
  String get formattedSubtotal {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(subtotal);
  }

  CartItemModel copyWith({
    String? id,
    ProductModel? product,
    String? selectedSize,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as String? ?? '',
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>? ?? {}),
      selectedSize: map['selectedSize'] as String? ?? '42',
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toMap(),
      'selectedSize': selectedSize,
      'quantity': quantity,
    };
  }
}