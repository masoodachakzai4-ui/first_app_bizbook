// ============================================================================
// File: providers/purchase_provider.dart
// Purpose: Manage purchase order data and operations
// Description: This provider handles all purchase-related operations:
//              - Create, edit, delete purchases
//              - Add/remove purchase items
//              - Track delivery status
//              - Calculate purchase totals
// ============================================================================

import 'package:flutter/material.dart';
import '../models/purchase.dart';

class PurchaseProvider extends ChangeNotifier {
  // List to store all purchases
  List<Purchase> _purchases = [];

  // Getter for purchases
  List<Purchase> get purchases => _purchases;

  // Get total number of purchases
  int get totalPurchases => _purchases.length;

  // Get total purchase amount
  double get totalPurchaseAmount {
    return _purchases.fold(0, (sum, purchase) => sum + purchase.subtotal);
  }

  // Get pending purchases count
  int get pendingPurchasesCount =>
      _purchases.where((p) => p.status != 'received').length;

  // Add a new purchase
  void addPurchase(Purchase purchase) {
    _purchases.add(purchase);
    notifyListeners();
  }

  // Update an existing purchase
  void updatePurchase(Purchase updatedPurchase) {
    final index = _purchases.indexWhere((p) => p.id == updatedPurchase.id);
    if (index != -1) {
      _purchases[index] = updatedPurchase;
      notifyListeners();
    }
  }

  // Delete a purchase
  void deletePurchase(String purchaseId) {
    _purchases.removeWhere((p) => p.id == purchaseId);
    notifyListeners();
  }

  // Get a single purchase by ID
  Purchase? getPurchaseById(String purchaseId) {
    try {
      return _purchases.firstWhere((p) => p.id == purchaseId);
    } catch (e) {
      return null;
    }
  }

  // Add item to purchase
  void addItemToPurchase(String purchaseId, PurchaseItem item) {
    final purchase = getPurchaseById(purchaseId);
    if (purchase != null) {
      purchase.items.add(item);
      updatePurchase(purchase);
    }
  }

  // Remove item from purchase
  void removeItemFromPurchase(String purchaseId, String itemId) {
    final purchase = getPurchaseById(purchaseId);
    if (purchase != null) {
      purchase.items.removeWhere((item) => item.id == itemId);
      updatePurchase(purchase);
    }
  }

  // Update item quantity
  void updateItemQuantity(String purchaseId, String itemId, int quantity) {
    final purchase = getPurchaseById(purchaseId);
    if (purchase != null) {
      final itemIndex = purchase.items.indexWhere((i) => i.id == itemId);
      if (itemIndex != -1) {
        purchase.items[itemIndex].quantity = quantity;
        updatePurchase(purchase);
      }
    }
  }

  // Mark purchase as received
  void markPurchaseAsReceived(String purchaseId) {
    final purchase = getPurchaseById(purchaseId);
    if (purchase != null) {
      purchase.status = 'received';
      purchase.actualDeliveryDate = DateTime.now();
      purchase.updatedAt = DateTime.now();
      updatePurchase(purchase);
    }
  }

  // Mark purchase as partial
  void markPurchaseAsPartial(String purchaseId) {
    final purchase = getPurchaseById(purchaseId);
    if (purchase != null) {
      purchase.status = 'partial';
      purchase.updatedAt = DateTime.now();
      updatePurchase(purchase);
    }
  }

  // Get purchases by status
  List<Purchase> getPurchasesByStatus(String status) {
    return _purchases.where((p) => p.status == status).toList();
  }

  // Get purchases by supplier
  List<Purchase> getPurchasesBySupplier(String supplierId) {
    return _purchases.where((p) => p.supplierId == supplierId).toList();
  }

  // Get purchases by date range
  List<Purchase> getPurchasesByDateRange(DateTime startDate, DateTime endDate) {
    return _purchases.where((p) {
      return p.purchaseDate.isAfter(startDate) &&
          p.purchaseDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  // Calculate total purchases for date range
  double calculatePurchasesForDateRange(
      DateTime startDate, DateTime endDate) {
    final purchases = getPurchasesByDateRange(startDate, endDate);
    return purchases.fold(0, (sum, purchase) => sum + purchase.subtotal);
  }

  // Get overdue purchases (not received after expected delivery date)
  List<Purchase> getOverduePurchases() {
    final now = DateTime.now();
    return _purchases.where((p) {
      return p.status != 'received' &&
          p.expectedDeliveryDate != null &&
          p.expectedDeliveryDate!.isBefore(now);
    }).toList();
  }

  // Clear all purchases (for testing)
  void clearAllPurchases() {
    _purchases = [];
    notifyListeners();
  }
}
