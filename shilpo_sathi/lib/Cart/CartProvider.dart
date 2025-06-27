import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Marketplace/MarketplacePage.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    final existingItem = state.firstWhere(
          (item) => item.product.name == product.name,
      orElse: () => CartItem(product: product, quantity: 0),
    );
    if (existingItem.quantity > 0) {
      existingItem.quantity++;
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void removeFromCart(CartItem item) {
    state = state.where((cartItem) => cartItem != item).toList();
  }

  void incrementQuantity(CartItem item) {
    item.quantity++;
    state = [...state];
  }

  void decrementQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      state = state.where((cartItem) => cartItem != item).toList();
    }
  }

  double get totalPrice {
    return state.fold(
      0,
          (sum, item) => sum + (double.parse(item.product.price.replaceAll('\$', '')) * item.quantity),
    );
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

