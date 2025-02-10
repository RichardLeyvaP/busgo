import 'dart:convert';
import 'package:http/http.dart' as http;

class HaulmerPayment {
  final String apiKey;
  final String deviceId;

  HaulmerPayment({required this.apiKey, required this.deviceId});

  Future<Map<String, dynamic>> startPayment({
    required double amount,
    required String description,
    required int dteType,
    required String contact,
    required String sourceName,
    required String sourceVersion,
  }) async {
    final url = Uri.parse("https://integrations.payment.haulmer.com/PaymentRequest/Create");
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
       "X-Api-Key": 'VGtcyYOqUM0x7ttAd2FL2CYuL2XiKhRC83AVT1GQMZ4PSacINB5gu9FTClvy9oijcNh3oY9j74bldwDQWVBvu8gLVYCa1DoxlbJBOod1oEcn2fbPGI3UWhkYi8mJrq', // 🔹 Agregamos la API Key en los headers
    };
    final body = jsonEncode({
      "Amount": amount.toInt(), // Convertimos a entero (sin centavos en CLP)
      "Device": 'TJ44243320217',
      "Description": description,
      "DteType": dteType,
      "extraData": {
        "exemptAmount": 0,
        "customFields": [
          {
            "name": "Contacto",
            "value": contact,
            "print": true
          }
        ],
        "sourceName": sourceName,
        "sourceVersion": sourceVersion
      }
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          "success": true,
          "paymentRequestId": data["paymentRequest"]["paymentRequestId"],
          "message": "Pago iniciado con éxito",
        };
      } else {
        return {
          "success": false,
          "errorCode": data["code"],
          "message": data["message"],
        };
      }
    } catch (e) {
      return {
        "success": false,
        "errorCode": "UNEXPECTED_ERROR",
        "message": "Error en la solicitud: $e",
      };
    }
  }
}
