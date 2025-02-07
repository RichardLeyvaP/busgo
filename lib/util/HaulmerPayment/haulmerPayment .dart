import 'dart:convert';
import 'package:http/http.dart' as http;

class HaulmerPayment_ANTES {
  final String apiKey;
  final String posId;

  HaulmerPayment_ANTES({required this.apiKey, required this.posId});

  Future<void> startPayment(double amount, String description, String callbackUrl) async {
    final url = Uri.parse("https://api.haulmer.com/payments");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };
    final body = jsonEncode({
      "apiKey": apiKey,
      "amount": (amount * 100).toInt(), // Convertir a centavos
      "currency": "CLP",
      "posId": posId,
      "description": description,
      "callbackUrl": callbackUrl,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Pago iniciado con éxito: ${data['status']}");
      } else {
        print("Error al iniciar el pago: ${response.body}");
      }
    } catch (e) {
      print("Error en la solicitud de pago: $e");
    }
  }
}
