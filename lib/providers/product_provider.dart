import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _searchResults = [];
  String _searchQuery = '';

  List<Product> get products => _products;
  List<Product> get searchResults =>
      _searchQuery.isEmpty ? _products : _searchResults;
  String get searchQuery => _searchQuery;
  int get totalProducts => _products.length;
  double get totalInventoryValue =>
      _products.fold(0, (sum, product) => sum + product.totalStockValue);
  int get lowStockCount =>
      _products.where((product) => product.isLowStock).length;

  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final rawProducts = prefs.getStringList('bizbook_products') ?? [];
    _products = rawProducts
        .map((item) => Product.fromJson(jsonDecode(item)))
        .toList();
    _searchResults = [];
    _searchQuery = '';
    notifyListeners();
  }

  Future<void> saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = _products
        .map((product) => jsonEncode(product.toJson()))
        .toList();
    await prefs.setStringList('bizbook_products', encoded);
  }

  Future<void> addProduct(Product product) async {
    _products.add(product);
    await saveProducts();
    notifyListeners();
  }

  Future<void> updateProduct(Product updatedProduct) async {
    final index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      await saveProducts();
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productId) async {
    _products.removeWhere((p) => p.id == productId);
    await saveProducts();
    notifyListeners();
  }

  Product? getProductById(String productId) {
    try {
      return _products.firstWhere((p) => p.id == productId);
    } catch (_) {
      return null;
    }
  }

  Future<bool> reduceStock(String productId, int quantity) async {
    final product = getProductById(productId);
    if (product != null && product.quantity >= quantity) {
      product.quantity -= quantity;
      await updateProduct(product);
      return true;
    }
    return false;
  }

  Future<void> increaseStock(String productId, int quantity) async {
    final product = getProductById(productId);
    if (product != null) {
      product.quantity += quantity;
      await updateProduct(product);
    }
  }

  void searchProducts(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _products
          .where(
            (product) =>
                product.name.toLowerCase().contains(_searchQuery) ||
                product.category.toLowerCase().contains(_searchQuery),
          )
          .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    notifyListeners();
  }

  List<Product> getProductsByCategory(String category) {
    return _products.where((p) => p.category == category).toList();
  }

  List<Product> getLowStockProducts() {
    return _products.where((p) => p.isLowStock).toList();
  }

  List<String> getAllCategories() {
    return _products.map((p) => p.category).toSet().toList();
  }

  double calculateTotalProfit() {
    return _products.fold(
      0,
      (sum, product) => sum + (product.profitPerUnit * product.quantity),
    );
  }

  Future<void> clearAllProducts() async {
    _products = [];
    _searchResults = [];
    _searchQuery = '';
    await saveProducts();
    notifyListeners();
  }
}
