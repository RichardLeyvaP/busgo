import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentService {
  // Definimos el canal de plataforma
  static const MethodChannel _channel = MethodChannel('com.example.BusGo');

  // Método para iniciar el pago
  Future<void> iniciarPago(Map<String, dynamic> request) async {
    try {
      // Enviar el request al canal nativo
      final bool success = await _channel.invokeMethod('sendPaymentIntent', request);
      if (success) {
        print('Pago procesado correctamente.');
      } else {
        print('Hubo un error al procesar el pago.');
      }
    } on PlatformException catch (e) {
      // Captura errores de la comunicación con el código nativo
      print('Error en el canal: ${e.message}');
    }
  }
}


class PaymentPage extends StatelessWidget {
  final PaymentService paymentService = PaymentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Proceso de Pago")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Datos de ejemplo para el pago
            Map<String, dynamic> paymentRequest = {
              'amount': 1000,
              'method': 'credit_card',
              'tip': 100,
              'installments': 3,
              // Añadir más datos según sea necesario
            };

            // Llamar al servicio de pago
            paymentService.iniciarPago(paymentRequest);
          },
          child: Text("Iniciar Pago"),
        ),
      ),
    );
  }
}
