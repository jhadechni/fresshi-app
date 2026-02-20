import 'package:fresshi/features/products/data/datasources/products_remote_datasource.dart';
import 'package:fresshi/features/products/data/repositories/products_repository_impl.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';
import 'package:fresshi/features/products/domain/repositories/products_repository.dart';
import 'package:fresshi/features/products/domain/usecases/get_categories.dart';
import 'package:fresshi/features/products/domain/usecases/get_product_by_id.dart';
import 'package:fresshi/features/products/domain/usecases/get_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiendita/tiendita.dart' as tiendita;

// --- Infrastructure providers ---

final tienditaProductRepositoryProvider = Provider<tiendita.ProductRepository>((
  ref,
) {
  return tiendita.ProductRepository();
});

final productsRemoteDatasourceProvider = Provider<ProductsRemoteDatasource>((
  ref,
) {
  return ProductsRemoteDatasourceImpl(
    ref.watch(tienditaProductRepositoryProvider),
  );
});

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepositoryImpl(ref.watch(productsRemoteDatasourceProvider));
});

// --- Use-case providers ---

final getProductsUseCaseProvider = Provider<GetProducts>((ref) {
  return GetProducts(ref.watch(productsRepositoryProvider));
});

final getProductByIdUseCaseProvider = Provider<GetProductById>((ref) {
  return GetProductById(ref.watch(productsRepositoryProvider));
});

final getCategoriesUseCaseProvider = Provider<GetCategories>((ref) {
  return GetCategories(ref.watch(productsRepositoryProvider));
});

// --- State providers ---

final productsProvider = AsyncNotifierProvider<ProductsNotifier, List<Product>>(
  ProductsNotifier.new,
);

class ProductsNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final result = await ref.watch(getProductsUseCaseProvider).call();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (products) => products,
    );
  }
}

final categoriesProvider =
    AsyncNotifierProvider<CategoriesNotifier, List<String>>(
      CategoriesNotifier.new,
    );

class CategoriesNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    final result = await ref.watch(getCategoriesUseCaseProvider).call();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (categories) => categories,
    );
  }
}

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

final filteredProductsProvider =
    AsyncNotifierProvider<FilteredProductsNotifier, List<Product>>(
      FilteredProductsNotifier.new,
    );

class FilteredProductsNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final category = ref.watch(selectedCategoryProvider);
    if (category == null) {
      return ref.watch(productsProvider.future);
    }
    final result = await ref
        .watch(productsRepositoryProvider)
        .getProductsByCategory(category);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (products) => products,
    );
  }
}
