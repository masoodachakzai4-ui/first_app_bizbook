// ============================================================================
// File: models/purchase.dart
// Purpose: Define the Purchase and PurchaseItem data models
// Description: Purchase represents a buying bill from a supplier.
//              It contains multiple purchase items (products bought).
// ============================================================================

class PurchaseItem {
  // Unique identifier
  final String id;

  // Product ID
  final String productId;

  // Product name
  final String productName;

  // Quantity purchased
  int quantity;

  // Cost per unit (what we paid)
  double costPrice;

  // Constructor
  PurchaseItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.costPrice,
  });

  // Calculate total for this item
  double get total => costPrice * quantity;

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'costPrice': costPrice,
    };
  }

  // Create from JSON
  factory PurchaseItem.fromJson(Map<String, dynamic> json) {
    return PurchaseItem(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      quantity: json['quantity'] ?? 0,
      costPrice: (json['costPrice'] ?? 0).toDouble(),
    );
  }
}

class Purchase {
  // Unique identifier / Purchase order number
  final String id;

  // Supplier ID
  final String supplierId;

  // Supplier name (stored for reference)
  final String supplierName;

  // List of items in purchase
  List<PurchaseItem> items;

  // Purchase date
  final DateTime purchaseDate;

  // Expected delivery date
  final DateTime? expectedDeliveryDate;

  // Actual delivery date
  DateTime? actualDeliveryDate;

  // Notes
  final String notes;

  // Purchase status: "pending", "received", "partial", "cancelled"
  String status;

  // When created
  final DateTime createdAt;

  // When last updated
  DateTime updatedAt;

  // Constructor
  Purchase({
    required this.id,
    required this.supplierId,
    required this.supplierName,
    required this.items,
    required this.purchaseDate,
    this.expectedDeliveryDate,
    this.actualDeliveryDate,
    this.notes = '',
    this.status = 'pending',
    required this.createdAt,
    required this.updatedAt,
  });

  // Calculate subtotal
  double get subtotal {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  // Get number of items
  int get itemCount => items.length;

  // Check if purchase is received
  bool get isReceived => status == 'received';

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'supplierId': supplierId,
      'supplierName': supplierName,
      'items': items.map((item) => item.toJson()).toList(),
      'purchaseDate': purchaseDate.toIso8601String(),
      'expectedDeliveryDate': expectedDeliveryDate?.toIso8601String(),
      'actualDeliveryDate': actualDeliveryDate?.toIso8601String(),
      'notes': notes,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'] ?? '',
      supplierId: json['supplierId'] ?? '',
      supplierName: json['supplierName'] ?? '',
      items:
          (json['items'] as List?)
              ?.map((item) => PurchaseItem.fromJson(item))
              .toList() ??
          [],
      purchaseDate: json['purchaseDate'] != null
          ? DateTime.parse(json['purchaseDate'])
          : DateTime.now(),
      expectedDeliveryDate: json['expectedDeliveryDate'] != null
          ? DateTime.parse(json['expectedDeliveryDate'])
          : null,
      actualDeliveryDate: json['actualDeliveryDate'] != null
          ? DateTime.parse(json['actualDeliveryDate'])
          : null,
      notes: json['notes'] ?? '',
      status: json['status'] ?? 'pending',
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
    return 'Purchase(id: $id, supplier: $supplierName, total: $subtotal)';
  }
}
