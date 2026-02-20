import 'package:dartz/dartz.dart';
import 'package:fresshi/core/errors/exceptions.dart';
import 'package:fresshi/core/errors/failures.dart';
import 'package:fresshi/core/logging/logging.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';
import 'package:fresshi/features/products/domain/repositories/products_repository.dart';
import 'package:fresshi/features/products/data/datasources/products_remote_datasource.dart';

class ProductsRepositoryImpl with DataLoggy implements ProductsRepository {
  final ProductsRemoteDatasource _remoteDatasource;

  ProductsRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    loggy.debug('Fetching all products');
    try {
      final models = await _remoteDatasource.getProducts();
      loggy.info('Successfully fetched ${models.length} products');
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      loggy.error('Server error fetching products', e);
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      loggy.warning('Network error fetching products: ${e.message}');
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String category,
  ) async {
    loggy.debug('Fetching products for category: $category');
    try {
      final models = await _remoteDatasource.getProductsByCategory(category);
      loggy.info('Fetched ${models.length} products for category: $category');
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      loggy.error('Server error fetching products by category: $category', e);
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      loggy.warning('Network error fetching category $category: ${e.message}');
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    loggy.debug('Fetching product with id: $id');
    try {
      final model = await _remoteDatasource.getProductById(id);
      loggy.info('Successfully fetched product: ${model.title}');
      return Right(model.toEntity());
    } on ServerException catch (e) {
      loggy.error('Server error fetching product $id', e);
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      loggy.warning('Network error fetching product $id: ${e.message}');
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    loggy.debug('Fetching categories');
    try {
      final categories = await _remoteDatasource.getCategories();
      loggy.info('Fetched ${categories.length} categories');
      return Right(categories);
    } on ServerException catch (e) {
      loggy.error('Server error fetching categories', e);
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      loggy.warning('Network error fetching categories: ${e.message}');
      return Left(NetworkFailure(e.message));
    }
  }
}
