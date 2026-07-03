// ============================================================================
// File: providers/invoice_provider.dart
// Purpose: Manage sales invoice data and operations
// Description: This provider handles all invoice-related operations:
//              - Create, edit, delete invoices
//              - Add/remove invoice items
//              - Calculate totals
//              - Filter by date or status
// ============================================================================

import 'package:flutter/material.dart';
import '../models/invoice.dart';

class InvoiceProvider extends ChangeNotifier {
  // List to store all invoices
  List<Invoice> _invoices = [];

  // Getter for invoices
  List<Invoice> get invoices => _invoices;

  // Get total number of invoices
  int get totalInvoices => _invoices.length;

  // Get total sales
  double get totalSales {
    return _invoices.fold(0, (sum, invoice) => sum + invoice.grandTotal);
  }

  // Get pending invoices count
  int get pendingInvoicesCount =>
      _invoices.where((i) => i.status != 'paid').length;

  // Add a new invoice
  void addInvoice(Invoice invoice) {
    _invoices.add(invoice);
    notifyListeners();
  }

  // Update an existing invoice
  void updateInvoice(Invoice updatedInvoice) {
    final index = _invoices.indexWhere((i) => i.id == updatedInvoice.id);
    if (index != -1) {
      _invoices[index] = updatedInvoice;
      notifyListeners();
    }
  }

  // Delete an invoice
  void deleteInvoice(String invoiceId) {
    _invoices.removeWhere((i) => i.id == invoiceId);
    notifyListeners();
  }

  // Get a single invoice by ID
  Invoice? getInvoiceById(String invoiceId) {
    try {
      return _invoices.firstWhere((i) => i.id == invoiceId);
    } catch (e) {
      return null;
    }
  }

  // Add item to invoice
  void addItemToInvoice(String invoiceId, InvoiceItem item) {
    final invoice = getInvoiceById(invoiceId);
    if (invoice != null) {
      invoice.items.add(item);
      updateInvoice(invoice);
    }
  }

  // Remove item from invoice
  void removeItemFromInvoice(String invoiceId, String itemId) {
    final invoice = getInvoiceById(invoiceId);
    if (invoice != null) {
      invoice.items.removeWhere((item) => item.id == itemId);
      updateInvoice(invoice);
    }
  }

  // Update item quantity
  void updateItemQuantity(String invoiceId, String itemId, int quantity) {
    final invoice = getInvoiceById(invoiceId);
    if (invoice != null) {
      final itemIndex = invoice.items.indexWhere((i) => i.id == itemId);
      if (itemIndex != -1) {
        invoice.items[itemIndex].quantity = quantity;
        updateInvoice(invoice);
      }
    }
  }

  // Finalize invoice (change from draft to finalized)
  void finalizeInvoice(String invoiceId) {
    final invoice = getInvoiceById(invoiceId);
    if (invoice != null) {
      invoice.status = 'finalized';
      invoice.updatedAt = DateTime.now();
      updateInvoice(invoice);
    }
  }

  // Mark invoice as paid
  void markInvoiceAsPaid(String invoiceId) {
    final invoice = getInvoiceById(invoiceId);
    if (invoice != null) {
      invoice.status = 'paid';
      invoice.updatedAt = DateTime.now();
      updateInvoice(invoice);
    }
  }

  // Mark invoice as partial
  void markInvoiceAsPartial(String invoiceId) {
    final invoice = getInvoiceById(invoiceId);
    if (invoice != null) {
      invoice.status = 'partial';
      invoice.updatedAt = DateTime.now();
      updateInvoice(invoice);
    }
  }

  // Get invoices by status
  List<Invoice> getInvoicesByStatus(String status) {
    return _invoices.where((i) => i.status == status).toList();
  }

  // Get invoices by customer
  List<Invoice> getInvoicesByCustomer(String customerId) {
    return _invoices.where((i) => i.customerId == customerId).toList();
  }

  // Get invoices by date range
  List<Invoice> getInvoicesByDateRange(DateTime startDate, DateTime endDate) {
    return _invoices.where((i) {
      return i.invoiceDate.isAfter(startDate) &&
          i.invoiceDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  // Calculate total sales for a date range
  double calculateSalesForDateRange(DateTime startDate, DateTime endDate) {
    final invoices = getInvoicesByDateRange(startDate, endDate);
    return invoices.fold(0, (sum, invoice) => sum + invoice.grandTotal);
  }

  // Calculate total pending amount
  double calculateTotalPending() {
    return _invoices
        .where((i) => i.status != 'paid')
        .fold(0, (sum, invoice) => sum + invoice.grandTotal);
  }

  // Clear all invoices (for testing)
  void clearAllInvoices() {
    _invoices = [];
    notifyListeners();
  }
}
