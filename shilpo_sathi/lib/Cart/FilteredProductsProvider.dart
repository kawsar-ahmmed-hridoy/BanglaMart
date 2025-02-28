import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Marketplace/MarketplacePage.dart';

class FilteredProductsNotifier extends StateNotifier<List<Product>> {
  final List<Product> allProducts;

  FilteredProductsNotifier(this.allProducts) : super(allProducts);

  void filterProducts(String query) {
    state = allProducts
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void sortByPriceLowToHigh() {
    state = [...state]..sort((a, b) {
      double priceA = double.parse(a.price.replaceAll('\$', ''));
      double priceB = double.parse(b.price.replaceAll('\$', ''));
      return priceA.compareTo(priceB);
    });
  }

  void sortByPriceHighToLow() {
    state = [...state]..sort((a, b) {
      double priceA = double.parse(a.price.replaceAll('\$', ''));
      double priceB = double.parse(b.price.replaceAll('\$', ''));
      return priceB.compareTo(priceA);
    });
  }

  void sortByName() {
    state = [...state]..sort((a, b) => a.name.compareTo(b.name));
  }

  void filterByCategory(String category) {
    if (category == 'All') {
      state = allProducts;
    } else {
      state = allProducts.where((product) => product.category == category).toList();
    }
  }

  void resetFilters() {
    state = allProducts;
  }

  void addProduct(Product newProduct) {
    allProducts.add(newProduct);
    state = allProducts;
  }
}

final filteredProductsProvider = StateNotifierProvider.family<FilteredProductsNotifier, List<Product>, List<Product>>(
      (ref, allProducts) => FilteredProductsNotifier(allProducts),
);