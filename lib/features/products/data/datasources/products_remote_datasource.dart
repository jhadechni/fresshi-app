import 'package:dio/dio.dart';
import 'package:fresshi/core/constants/api_constants.dart';
import 'package:fresshi/core/errors/exceptions.dart';
import 'package:fresshi/features/products/data/models/product_model.dart';

abstract interface class ProductsRemoteDatasource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<ProductModel> getProductById(int id);
  Future<List<String>> getCategories();
}

class ProductsRemoteDatasourceImpl implements ProductsRemoteDatasource {
  final Dio _dio;

  const ProductsRemoteDatasourceImpl(this._dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get(ApiConstants.products);
      return (response.data as List)
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to fetch products',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response =
          await _dio.get(ApiConstants.productsByCategory(category));
      return (response.data as List)
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to fetch products by category',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _dio.get(ApiConstants.productById(id));
      return ProductModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to fetch product',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get(ApiConstants.categories);
      return List<String>.from(response.data as List);
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to fetch categories',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
