import 'package:equatable/equatable.dart';
import 'package:fresshi/features/products/domain/entities/product.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);

  double get totalPrice => product.price * quantity;

  @override
  List<Object> get props => [product.id];
}
