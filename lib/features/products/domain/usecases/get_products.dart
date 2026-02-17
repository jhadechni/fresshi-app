import 'package:dartz/dartz.dart';
import 'package:fresshi/core/errors/failures.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';
import 'package:fresshi/features/products/domain/repositories/products_repository.dart';

class GetProducts {
  final ProductsRepository _repository;

  const GetProducts(this._repository);

  Future<Either<Failure, List<Product>>> call() => _repository.getProducts();
}
