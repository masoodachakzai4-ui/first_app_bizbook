// ============================================================================
// File: models/customer.dart
// Purpose: Define the Customer data model
// Description: This file contains the Customer class which represents a
//              customer in the system. It stores customer info like name,
//              contact, and address.
// ============================================================================

class Customer {
  // Unique identifier
  final String id;

  // Customer name
  final String name;

  // Customer phone number
  final String phone;

  // Customer email
  final String email;

  // Customer address
  final String address;

  // City
  final String city;

  // Customer type: individual or business
  final String customerType; // "individual" or "business"

  // Opening balance (how much customer owed at the start)
  double openingBalance;

  // Status: active or inactive
  final String status; // "active" or "inactive"

  // Notes about customer
  final String notes;

  // When the customer was created
  final DateTime createdAt;

  // When the customer was last updated
  DateTime updatedAt;

  // Constructor
  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.customerType,
    required this.openingBalance,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a copy with some properties changed
  Customer copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? address,
    String? city,
    String? customerType,
    double? openingBalance,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      customerType: customerType ?? this.customerType,
      openingBalance: openingBalance ?? this.openingBalance,
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
      'phone': phone,
      'email': email,
      'address': address,
      'city': city,
      'customerType': customerType,
      'openingBalance': openingBalance,
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      customerType: json['customerType'] ?? 'individual',
      openingBalance: (json['openingBalance'] ?? 0).toDouble(),
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
    return 'Customer(id: $id, name: $name, phone: $phone)';
  }
}
