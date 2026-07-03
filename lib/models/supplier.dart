// ============================================================================
// File: models/supplier.dart
// Purpose: Define the Supplier data model
// Description: This file contains the Supplier class which represents a
//              supplier from whom we buy products.
// ============================================================================

class Supplier {
  // Unique identifier
  final String id;

  // Supplier name
  final String name;

  // Contact person name
  final String contactPerson;

  // Phone number
  final String phone;

  // Email address
  final String email;

  // Supplier address
  final String address;

  // City
  final String city;

  // Opening balance (how much we owed at start)
  double openingBalance;

  // Payment terms (e.g., "Net 30", "COD")
  final String paymentTerms;

  // Status: active or inactive
  final String status; // "active" or "inactive"

  // Notes
  final String notes;

  // When created
  final DateTime createdAt;

  // When last updated
  DateTime updatedAt;

  // Constructor
  Supplier({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.openingBalance,
    required this.paymentTerms,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a copy with some properties changed
  Supplier copyWith({
    String? id,
    String? name,
    String? contactPerson,
    String? phone,
    String? email,
    String? address,
    String? city,
    double? openingBalance,
    String? paymentTerms,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Supplier(
      id: id ?? this.id,
      name: name ?? this.name,
      contactPerson: contactPerson ?? this.contactPerson,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      openingBalance: openingBalance ?? this.openingBalance,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactPerson': contactPerson,
      'phone': phone,
      'email': email,
      'address': address,
      'city': city,
      'openingBalance': openingBalance,
      'paymentTerms': paymentTerms,
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      contactPerson: json['contactPerson'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      openingBalance: (json['openingBalance'] ?? 0).toDouble(),
      paymentTerms: json['paymentTerms'] ?? '',
      status: json['status'] ?? 'active',
      notes: json['notes'] ?? '',
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
    return 'Supplier(id: $id, name: $name, phone: $phone)';
  }
}
