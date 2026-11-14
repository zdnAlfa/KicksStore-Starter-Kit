import 'package:e_commerce/app/core/network/dio_exception.dart';
import 'package:e_commerce/app/core/network/result.dart';
import 'package:e_commerce/app/data/models/product_model.dart';
import 'package:e_commerce/app/data/remote/product_remote_datasource.dart';

/// Kontrak abstraksi repository data produk (Sesi 05: Clean Architecture Repository Pattern)
abstract class ProductRepository {
  /// Mengambil data produk dengan return type modern [Result] (Success atau Failure)
  Future<Result<List<ProductModel>, String>> fetchProducts();
}

/// Implementasi nyata ProductRepository dengan Constructor Injection
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  /// Constructor Injection: menerima ProductRemoteDataSource dari luar (bisa remote atau mock)
  ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<ProductModel>, String>> fetchProducts() async {
    try {
      final products = await _remoteDataSource.fetchProducts();
      return Success(products);
    } on NetworkFailure catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure('Gagal memuat katalog produk: ${e.toString()}');
    }
  }
}