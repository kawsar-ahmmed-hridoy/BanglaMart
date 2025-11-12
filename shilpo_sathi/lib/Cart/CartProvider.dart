import 'package:flutter/material.dart';
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

  void addToCart2(Product product) {
    //item.add(product);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    state = state.where((cartItem) => cartItem != item).toList();
  }

  void incrementQuantity(CartItem item) {
    item.quantity++;
    state = [...state];
  }

  void decrementQuantity(CartItem item) {
    final index = state.indexWhere((element) => element.product == item.product);
    if (index != -1) {
      final current = state[index];
      if (current.quantity > 1) {
        state = [
          ...state.sublist(0, index),
          CartItem(product: current.product, quantity: current.quantity - 1),
          ...state.sublist(index + 1),
        ];
      } else {
        state = [
          ...state.sublist(0, index),
          ...state.sublist(index + 1),
        ];
      }
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

  void notifyListeners() {
    print("Hello");
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
}


);