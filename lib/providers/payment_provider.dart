// ============================================================================
// File: providers/payment_provider.dart
// Purpose: Manage payment data and operations
// Description: This provider handles all payment-related operations:
//              - Record customer payments
//              - Record supplier payments
//              - Calculate dues
//              - Filter payments by date/method/status
// ============================================================================

import 'package:flutter/material.dart';
import '../models/payment.dart';

class PaymentProvider extends ChangeNotifier {
  // List to store all payments
  List<Payment> _payments = [];

  // Getter for payments
  List<Payment> get payments => _payments;

  // Get total number of payments
  int get totalPayments => _payments.length;

  // Get total amount received from customers
  double get totalCustomerPayments {
    return _payments
        .where((p) => p.type == 'customer' && p.status == 'completed')
        .fold(0, (sum, payment) => sum + payment.amount);
  }

  // Get total amount paid to suppliers
  double get totalSupplierPayments {
    return _payments
        .where((p) => p.type == 'supplier' && p.status == 'completed')
        .fold(0, (sum, payment) => sum + payment.amount);
  }

  // Get pending payments count
  int get pendingPaymentsCount =>
      _payments.where((p) => p.status == 'pending').length;

  // Add a new payment
  void addPayment(Payment payment) {
    _payments.add(payment);
    notifyListeners();
  }

  // Update an existing payment
  void updatePayment(Payment updatedPayment) {
    final index = _payments.indexWhere((p) => p.id == updatedPayment.id);
    if (index != -1) {
      _payments[index] = updatedPayment;
      notifyListeners();
    }
  }

  // Delete a payment
  void deletePayment(String paymentId) {
    _payments.removeWhere((p) => p.id == paymentId);
    notifyListeners();
  }

  // Get a single payment by ID
  Payment? getPaymentById(String paymentId) {
    try {
      return _payments.firstWhere((p) => p.id == paymentId);
    } catch (e) {
      return null;
    }
  }

  // Get all customer payments
  List<Payment> getCustomerPayments() {
    return _payments.where((p) => p.type == 'customer').toList();
  }

  // Get all supplier payments
  List<Payment> getSupplierPayments() {
    return _payments.where((p) => p.type == 'supplier').toList();
  }

  // Get payments by status
  List<Payment> getPaymentsByStatus(String status) {
    return _payments.where((p) => p.status == status).toList();
  }

  // Get payments by type
  List<Payment> getPaymentsByType(String type) {
    return _payments.where((p) => p.type == type).toList();
  }

  // Get payments by method
  List<Payment> getPaymentsByMethod(String method) {
    return _payments.where((p) => p.paymentMethod == method).toList();
  }

  // Get payments for a specific party (customer or supplier)
  List<Payment> getPaymentsForParty(String partyId) {
    return _payments.where((p) => p.relatedPartyId == partyId).toList();
  }

  // Get payments by date range
  List<Payment> getPaymentsByDateRange(DateTime startDate, DateTime endDate) {
    return _payments.where((p) {
      return p.paymentDate.isAfter(startDate) &&
          p.paymentDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  // Calculate total amount for date range
  double calculatePaymentsForDateRange(DateTime startDate, DateTime endDate) {
    final datePayments = getPaymentsByDateRange(startDate, endDate);
    return datePayments.fold(0, (sum, payment) => sum + payment.amount);
  }

  // Calculate total amount received from specific customer
  double calculateCustomerPaymentTotal(String customerId) {
    final customerPayments = _payments
        .where((p) =>
            p.type == 'customer' &&
            p.relatedPartyId == customerId &&
            p.status == 'completed')
        .toList();
    return customerPayments.fold(0, (sum, payment) => sum + payment.amount);
  }

  // Calculate total amount paid to specific supplier
  double calculateSupplierPaymentTotal(String supplierId) {
    final supplierPayments = _payments
        .where((p) =>
            p.type == 'supplier' &&
            p.relatedPartyId == supplierId &&
            p.status == 'completed')
        .toList();
    return supplierPayments.fold(0, (sum, payment) => sum + payment.amount);
  }

  // Get all payment methods used
  List<String> getAllPaymentMethods() {
    return _payments.map((p) => p.paymentMethod).toSet().toList();
  }

  // Clear all payments (for testing)
  void clearAllPayments() {
    _payments = [];
    notifyListeners();
  }
}
