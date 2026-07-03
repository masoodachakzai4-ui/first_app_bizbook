// ============================================================================
// File: models/payment.dart
// Purpose: Define the Payment data model
// Description: Payment represents money received from customers or paid to
//              suppliers. It tracks payment amount, method, date, etc.
// ============================================================================

class Payment {
  // Unique identifier
  final String id;

  // Type: "customer" (money we receive) or "supplier" (money we pay)
  final String type; // "customer" or "supplier"

  // Customer or Supplier ID
  final String relatedPartyId;

  // Customer or Supplier name
  final String relatedPartyName;

  // Invoice ID (if payment is for specific invoice)
  final String? invoiceOrPurchaseId;

  // Amount paid
  double amount;

  // Payment date
  final DateTime paymentDate;

  // Payment method: "cash", "check", "bank_transfer", "card", "online"
  final String paymentMethod;

  // Reference number (check number, transaction ID, etc.)
  final String? referenceNumber;

  // Notes
  final String notes;

  // Status: "completed", "pending", "failed"
  String status;

  // When created
  final DateTime createdAt;

  // When last updated
  DateTime updatedAt;

  // Constructor
  Payment({
    required this.id,
    required this.type,
    required this.relatedPartyId,
    required this.relatedPartyName,
    this.invoiceOrPurchaseId,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
    this.referenceNumber,
    this.notes = '',
    this.status = 'completed',
    required this.createdAt,
    required this.updatedAt,
  });

  // Check if this is customer payment
  bool get isCustomerPayment => type == 'customer';

  // Check if this is supplier payment
  bool get isSupplierPayment => type == 'supplier';

  // Create a copy with some properties changed
  Payment copyWith({
    String? id,
    String? type,
    String? relatedPartyId,
    String? relatedPartyName,
    String? invoiceOrPurchaseId,
    double? amount,
    DateTime? paymentDate,
    String? paymentMethod,
    String? referenceNumber,
    String? notes,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Payment(
      id: id ?? this.id,
      type: type ?? this.type,
      relatedPartyId: relatedPartyId ?? this.relatedPartyId,
      relatedPartyName: relatedPartyName ?? this.relatedPartyName,
      invoiceOrPurchaseId: invoiceOrPurchaseId ?? this.invoiceOrPurchaseId,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'relatedPartyId': relatedPartyId,
      'relatedPartyName': relatedPartyName,
      'invoiceOrPurchaseId': invoiceOrPurchaseId,
      'amount': amount,
      'paymentDate': paymentDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'referenceNumber': referenceNumber,
      'notes': notes,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] ?? '',
      type: json['type'] ?? 'customer',
      relatedPartyId: json['relatedPartyId'] ?? '',
      relatedPartyName: json['relatedPartyName'] ?? '',
      invoiceOrPurchaseId: json['invoiceOrPurchaseId'],
      amount: (json['amount'] ?? 0).toDouble(),
      paymentDate: json['paymentDate'] != null
          ? DateTime.parse(json['paymentDate'])
          : DateTime.now(),
      paymentMethod: json['paymentMethod'] ?? 'cash',
      referenceNumber: json['referenceNumber'],
      notes: json['notes'] ?? '',
      status: json['status'] ?? 'completed',
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
    return 'Payment(id: $id, amount: $amount, from: $relatedPartyName)';
  }
}
