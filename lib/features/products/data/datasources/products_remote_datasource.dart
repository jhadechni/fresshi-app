import 'package:fresshi/core/errors/exceptions.dart';
import 'package:fresshi/features/products/data/models/product_model.dart';
import 'package:tiendita/tiendita.dart' as tiendita;

abstract interface class ProductsRemoteDatasource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<ProductModel> getProductById(int id);
  Future<List<String>> getCategories();
}

class ProductsRemoteDatasourceImpl implements ProductsRemoteDatasource {
  final tiendita.ProductRepository _productRepository;

  const ProductsRemoteDatasourceImpl(this._productRepository);

  @override
  Future<List<ProductModel>> getProducts() async {
    final result = await _productRepository.getProducts();
    switch (result) {
      case tiendita.Ok(:final value):
        return value.map(_toProductModel).toList();
      case tiendita.Error(:final error):
        throw _mapException(error, fallbackMessage: 'Failed to fetch products');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final result = await _productRepository.getProductsByCategory(category);
    switch (result) {
      case tiendita.Ok(:final value):
        return value.map(_toProductModel).toList();
      case tiendita.Error(:final error):
        throw _mapException(
          error,
          fallbackMessage: 'Failed to fetch products by category',
        );
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final result = await _productRepository.getProduct(id);
    switch (result) {
      case tiendita.Ok(:final value):
        return _toProductModel(value);
      case tiendita.Error(:final error):
        throw _mapException(error, fallbackMessage: 'Failed to fetch product');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    final result = await _productRepository.getCategories();
    switch (result) {
      case tiendita.Ok(:final value):
        return value;
      case tiendita.Error(:final error):
        throw _mapException(
          error,
          fallbackMessage: 'Failed to fetch categories',
        );
    }
  }

  ProductModel _toProductModel(tiendita.Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      category: product.category,
      image: product.image,
      rating: RatingModel(
        rate: product.rating.rate,
        count: product.rating.count,
      ),
    );
  }

  Exception _mapException(Exception error, {required String fallbackMessage}) {
    if (error is tiendita.NetworkException) {
      return NetworkException(error.message);
    }

    if (error is tiendita.TienditaException) {
      return ServerException(error.message, statusCode: error.statusCode);
    }

    return ServerException(fallbackMessage);
  }
}
