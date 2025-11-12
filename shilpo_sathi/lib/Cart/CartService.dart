
import 'CartItem.dart';

class CartService {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(CartItem item) {
    _items.add(item);
  }

  void removeItem(CartItem item) {
    _items.remove(item);
  }

  double calculateTotal() {
    return _items.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  double calculateTax() {
    return calculateTotal() * 0.1; // 10% tax
  }

  double calculateGrandTotal() {
    return calculateTotal() + calculateTax();
  }
}
