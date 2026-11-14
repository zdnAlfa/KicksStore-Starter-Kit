import 'package:e_commerce/app/core/network/dio_client.dart';
import 'package:e_commerce/app/data/models/product_model.dart';

/// Kontrak abstraksi data remote khusus modul produk (Sesi 05: REST API Networking)
abstract class ProductRemoteDataSource {
  /// Mengambil data produk dari REST API
  Future<List<ProductModel>> fetchProducts();
}

/// Implementasi nyata ProductRemoteDataSource menggunakan DioClient
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient _dioClient;

  /// Constructor Injection: menerima DioClient dari luar
  ProductRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final response = await _dioClient.get('/products/category/mens-shoes');
    final data = response.data;

    if (data is Map<String, dynamic> && data['products'] is List) {
      final List list = data['products'] as List;
      return list
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}