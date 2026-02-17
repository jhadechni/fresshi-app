import 'package:dartz/dartz.dart';
import 'package:fresshi/core/errors/failures.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';
import 'package:fresshi/features/products/domain/repositories/products_repository.dart';

class GetProductById {
  final ProductsRepository _repository;

  const GetProductById(this._repository);

  Future<Either<Failure, Product>> call(int id) =>
      _repository.getProductById(id);
}
