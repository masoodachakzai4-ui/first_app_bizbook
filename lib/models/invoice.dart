// ============================================================================
// File: models/invoice.dart
// Purpose: Define the Invoice and InvoiceItem data models
// Description: Invoice represents a sales bill. It contains multiple invoice
//              items (products). Each invoice item has product info and qty.
// ============================================================================

class InvoiceItem {
  // Unique identifier
  final String id;

  // Product ID
  final String productId;

  // Product name (stored for reference)
  final String productName;

  // Quantity sold
  int quantity;

  // Unit price
  double unitPrice;

  // Discount per unit (optional)
  double discount;

  // Constructor
  InvoiceItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.discount = 0,
  });

  // Calculate total for this item
  double get total => (unitPrice * quantity) - (discount * quantity);

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'discount': discount,
    };
  }

  // Create from JSON
  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      quantity: json['quantity'] ?? 0,
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
    );
  }
}

class Invoice {
  // Unique identifier / Invoice number
  final String id;

  // Customer ID
  final String customerId;

  // Customer name (stored for reference)
  final String customerName;

  // List of items in the invoice
  List<InvoiceItem> items;

  // Invoice date
  final DateTime invoiceDate;

  // Due date for payment
  final DateTime? dueDate;

  // Discount on entire invoice (optional)
  double discount;

  // Tax amount (optional)
  double tax;

  // Notes on invoice
  final String notes;

  // Invoice status: "draft", "finalized", "paid", "partial"
  String status;

  // When created
  final DateTime createdAt;

  // When last updated
  DateTime updatedAt;

  // Constructor
  Invoice({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.items,
    required this.invoiceDate,
    this.dueDate,
    this.discount = 0,
    this.tax = 0,
    this.notes = '',
    this.status = 'draft',
    required this.createdAt,
    required this.updatedAt,
  });

  // Calculate subtotal (sum of all items)
  double get subtotal {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  // Calculate total after discount
  double get totalAfterDiscount => subtotal - discount;

  // Calculate grand total (with tax)
  double get grandTotal => totalAfterDiscount + tax;

  // Get number of items
  int get itemCount => items.length;

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'items': items.map((item) => item.toJson()).toList(),
      'invoiceDate': invoiceDate.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'discount': discount,
      'tax': tax,
      'notes': notes,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] ?? '',
      customerId: json['customerId'] ?? '',
      customerName: json['customerName'] ?? '',
      items: (json['items'] as List?)
              ?.map((item) => InvoiceItem.fromJson(item))
              .toList() ??
          [],
      invoiceDate: json['invoiceDate'] != null
          ? DateTime.parse(json['invoiceDate'])
          : DateTime.now(),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      discount: (json['discount'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      notes: json['notes'] ?? '',
      status: json['status'] ?? 'draft',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'Invoice(id: $id, customer: $customerName, total: $grandTotal)';
  }
}
