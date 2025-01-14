import 'dart:convert';

class PaymentData {
  final int id;
  final String stripeChargeId;
  final double amount;
  final String currency;
  final String paymentStatus;
  final PaymentDetails paymentDetails;

  PaymentData({
    required this.id,
    required this.stripeChargeId,
    required this.amount,
    required this.currency,
    required this.paymentStatus,
    required this.paymentDetails,
  });

  // Método para mapear desde JSON
  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      id: json['id'],
      stripeChargeId: json['stripe_charge_id'],
      amount: double.tryParse(json['amount']) ?? 0.0,
      currency: json['currency'],
      paymentStatus: json['payment_status'],
      paymentDetails: PaymentDetails.fromJson(jsonDecode(json['payment_details'])),
    );
  }
}

class PaymentDetails {
  final String id;
  final String object;
  final int amount;
  final int amountReceived;
  final String clientSecret;
  final String currency;
  final String description;
  final String status;
  final String paymentMethod;

  PaymentDetails({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountReceived,
    required this.clientSecret,
    required this.currency,
    required this.description,
    required this.status,
    required this.paymentMethod,
  });

  // Método para mapear desde JSON
  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      id: json['id'],
      object: json['object'],
      amount: json['amount'],
      amountReceived: json['amount_received'],
      clientSecret: json['client_secret'],
      currency: json['currency'],
      description: json['description'],
      status: json['status'],
      paymentMethod: json['payment_method'],
    );
  }
}

// Clase principal para mapear la lista
class PaymentResponse {
  final List<PaymentData> data;

  PaymentResponse({required this.data});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      data: (json['data'] as List).map((item) => PaymentData.fromJson(item)).toList(),
    );
  }
}
