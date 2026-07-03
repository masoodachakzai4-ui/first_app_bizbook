// ============================================================================
// File: models/product.dart
// Purpose: Define the Product data model
// Description: This file contains the Product class which represents a product
//              in the inventory. It has properties like name, price, stock, etc.
//              Models are like blueprints that define data structure.
// ============================================================================

class Product {
  // Unique identifier for each product
  final String id;

  // Product name (e.g., "Laptop", "Mouse")
  final String name;

  // Product description
  final String description;

  // Selling price
  final double sellingPrice;

  // Cost price (what we paid for it)
  final double costPrice;

  // Current stock quantity
  int quantity;

  // Product category (e.g., "Electronics", "Accessories")
  final String category;

  // Unit of measurement (e.g., "Piece", "Box", "kg")
  final String unit;

  // Reorder level - alert when stock falls below this
  final int reorderLevel;

  // When the product was created
  final DateTime createdAt;

  // When the product was last updated
  DateTime updatedAt;

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.sellingPrice,
    required this.costPrice,
    required this.quantity,
    required this.category,
    required this.unit,
    required this.reorderLevel,
    required this.createdAt,
    required this.updatedAt,
  });

  // Get profit per unit (selling price - cost price)
  double get profitPerUnit => sellingPrice - costPrice;

  // Get total value of stock at selling price
  double get totalStockValue => sellingPrice * quantity;

  // Check if product is low on stock
  bool get isLowStock => quantity <= reorderLevel;

  // Create a copy of this product with some properties changed
  // Useful when we want to update a product
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? sellingPrice,
    double? costPrice,
    int? quantity,
    String? category,
    String? unit,
    int? reorderLevel,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      costPrice: costPrice ?? this.costPrice,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Convert Product to JSON (for saving to database or API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sellingPrice': sellingPrice,
      'costPrice': costPrice,
      'quantity': quantity,
      'category': category,
      'unit': unit,
      'reorderLevel': reorderLevel,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create Product from JSON (for loading from database or API)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      sellingPrice: (json['sellingPrice'] ?? 0).toDouble(),
      costPrice: (json['costPrice'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      category: json['category'] ?? '',
      unit: json['unit'] ?? '',
      reorderLevel: json['reorderLevel'] ?? 0,
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
    return 'Product(id: $id, name: $name, quantity: $quantity, price: $sellingPrice)';
  }
}
