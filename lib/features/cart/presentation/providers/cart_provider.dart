import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';
import 'package:fresshi/features/cart/domain/entities/cart_item.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addItem(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i],
      ];
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  void removeItem(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }
    state = [
      for (final item in state)
        if (item.product.id == productId)
          item.copyWith(quantity: quantity)
        else
          item,
    ];
  }

  void clear() => state = [];

  double get totalPrice =>
      state.fold(0, (sum, item) => sum + item.totalPrice);

  int get itemCount => state.fold(0, (sum, item) => sum + item.quantity);
}

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);
