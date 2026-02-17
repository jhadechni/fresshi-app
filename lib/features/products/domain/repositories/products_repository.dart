import 'package:dartz/dartz.dart';
import 'package:fresshi/core/errors/failures.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';

abstract interface class ProductsRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);
  Future<Either<Failure, Product>> getProductById(int id);
  Future<Either<Failure, List<String>>> getCategories();
}
