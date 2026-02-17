import 'package:dartz/dartz.dart';
import 'package:fresshi/core/errors/exceptions.dart';
import 'package:fresshi/core/errors/failures.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';
import 'package:fresshi/features/products/domain/repositories/products_repository.dart';
import 'package:fresshi/features/products/data/datasources/products_remote_datasource.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDatasource _remoteDatasource;

  const ProductsRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final models = await _remoteDatasource.getProducts();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final models = await _remoteDatasource.getProductsByCategory(category);
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    try {
      final model = await _remoteDatasource.getProductById(id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await _remoteDatasource.getCategories();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }
}
