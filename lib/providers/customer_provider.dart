import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/customer.dart';

class CustomerProvider extends ChangeNotifier {
  List<Customer> _customers = [];
  List<Customer> _searchResults = [];
  String _searchQuery = '';

  List<Customer> get customers => _customers;
  List<Customer> get searchResults =>
      _searchQuery.isEmpty ? _customers : _searchResults;
  String get searchQuery => _searchQuery;
  int get totalCustomers => _customers.length;
  int get activeCustomersCount =>
      _customers.where((c) => c.status == 'active').length;

  Future<void> loadCustomers() async {
    final prefs = await SharedPreferences.getInstance();
    final rawCustomers = prefs.getStringList('bizbook_customers') ?? [];
    _customers = rawCustomers
        .map((item) => Customer.fromJson(jsonDecode(item)))
        .toList();
    _searchResults = [];
    _searchQuery = '';
    notifyListeners();
  }

  Future<void> saveCustomers() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = _customers
        .map((customer) => jsonEncode(customer.toJson()))
        .toList();
    await prefs.setStringList('bizbook_customers', encoded);
  }

  Future<void> addCustomer(Customer customer) async {
    _customers.add(customer);
    await saveCustomers();
    notifyListeners();
  }

  Future<void> updateCustomer(Customer updatedCustomer) async {
    final index = _customers.indexWhere((c) => c.id == updatedCustomer.id);
    if (index != -1) {
      _customers[index] = updatedCustomer;
      await saveCustomers();
      notifyListeners();
    }
  }

  Future<void> deleteCustomer(String customerId) async {
    _customers.removeWhere((c) => c.id == customerId);
    await saveCustomers();
    notifyListeners();
  }

  Customer? getCustomerById(String customerId) {
    try {
      return _customers.firstWhere((c) => c.id == customerId);
    } catch (_) {
      return null;
    }
  }

  void searchCustomers(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _customers
          .where(
            (customer) =>
                customer.name.toLowerCase().contains(_searchQuery) ||
                customer.phone.contains(_searchQuery) ||
                customer.email.toLowerCase().contains(_searchQuery),
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

  List<Customer> getCustomersByType(String type) {
    return _customers.where((c) => c.customerType == type).toList();
  }

  List<String> getAllCities() {
    return _customers.map((c) => c.city).toSet().toList();
  }

  List<Customer> getCustomersByCity(String city) {
    return _customers.where((c) => c.city == city).toList();
  }

  List<Customer> getActiveCustomers() {
    return _customers.where((c) => c.status == 'active').toList();
  }

  double calculateTotalDues() {
    return _customers.fold(0, (sum, customer) => sum + customer.openingBalance);
  }

  Future<void> clearAllCustomers() async {
    _customers = [];
    _searchResults = [];
    _searchQuery = '';
    await saveCustomers();
    notifyListeners();
  }
}
