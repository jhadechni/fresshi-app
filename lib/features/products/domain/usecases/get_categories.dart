import 'package:dartz/dartz.dart';
import 'package:fresshi/core/errors/failures.dart';
import 'package:fresshi/features/products/domain/repositories/products_repository.dart';

class GetCategories {
  final ProductsRepository _repository;

  const GetCategories(this._repository);

  Future<Either<Failure, List<String>>> call() => _repository.getCategories();
}
