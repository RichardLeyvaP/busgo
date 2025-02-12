import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/services.dart';

class PaymentScreenNative extends StatefulWidget {
  const PaymentScreenNative({super.key});

  @override
  _PaymentScreenNativeState createState() => _PaymentScreenNativeState();
}

class _PaymentScreenNativeState extends State<PaymentScreenNative> {
  static const platform = MethodChannel('com.example.app/payment_result');

  String? transactionStatus;
  String? errorMessage;

  Future<void> _launchPaymentApp() async {
    try {
      // Construir JSON de pago
      final Map<String, dynamic> paymentData = {
        "amount": "100.00",
        "currency": "BRL",
        "orderId": "123456"
      };
      final String paymentJson = jsonEncode(paymentData);

      // Intent para abrir la app de pagos de Haulmer
      final intent = AndroidIntent(
        action: 'android.intent.action.SEND',
        package: 'com.haulmer.paymentapp.dev', // Verifica que este sea el paquete correcto
        type: 'text/json',
        arguments: {
          'android.intent.extra.TEXT': paymentJson, // Enviar JSON en el intent
        },
        flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
      );

      await intent.launch();

      // Esperar resultado del pago desde el canal nativo
      final result = await platform.invokeMethod<Map<dynamic, dynamic>>('getPaymentResult');

      if (result != null) {
        // Convertimos el Map a un Map<String, dynamic>
        final response = Map<String, dynamic>.from(result);

        setState(() {
          transactionStatus = response["transactionStatus"] == true ? "Éxito" : "Fallido";
          errorMessage = response["errorMessage"];
        });
      }
    } catch (e) {
      print("Error al iniciar la aplicación de pagos: $e");
      setState(() {
        errorMessage = "Error al iniciar la aplicación de pagos: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pago con App Externa')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _launchPaymentApp,
              child: Text('Realizar Pago'),
            ),
            SizedBox(height: 20),
            if (transactionStatus != null)
              Text("Estado: $transactionStatus", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (errorMessage != null)
              Text("Error: $errorMessage", style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}





















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
// import 'package:flutter/services.dart';

// class PaymentScreenNative extends StatefulWidget {
//   const PaymentScreenNative({super.key});

//   @override
//   _PaymentScreenNativeState createState() => _PaymentScreenNativeState();
// }

// class _PaymentScreenNativeState extends State<PaymentScreenNative> {
//   static const platform = MethodChannel('com.example.app/payment_result');

//   String? transactionStatus;
//   String? errorMessage;

//   Future<void> _launchPaymentApp() async {
//     try {
//       // Construir JSON de pago
//       final Map<String, dynamic> paymentData = {
//         "amount": "100.00",
//         "currency": "BRL",
//         "orderId": "123456"
//       };
//       final String paymentJson = jsonEncode(paymentData);

//       // Intent para abrir la app de pagos de Haulmer
//       final intent = AndroidIntent(
//         action: 'android.intent.action.SEND',
//         package: 'com.haulmer.paymentapp.dev', // Asegúrate de que esta es la correcta
//         type: 'text/json',
//         arguments: {
//           'android.intent.extra.TEXT': paymentJson, // Enviar JSON en el intent
//         },
//         flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
//       );

//       await intent.launch();

//       // Esperar resultado del pago desde el canal nativo
//       final result = await platform.invokeMethod('getPaymentResult');

//       if (result != null) {
//         Map<String, dynamic> response = jsonDecode(result);
//         setState(() {
//           transactionStatus = response["transactionStatus"] == true ? "Éxito" : "Fallido";
//           errorMessage = response["errorMessage"];
//         });
//       }
//     } catch (e) {
//       print("Error al iniciar la aplicación de pagos: $e");
//       setState(() {
//         errorMessage = "Error al iniciar la aplicación de pagos: $e";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Pago con App Externa')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _launchPaymentApp,
//               child: Text('Realizar Pago'),
//             ),
//             SizedBox(height: 20),
//             if (transactionStatus != null)
//               Text("Estado: $transactionStatus", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             if (errorMessage != null)
//               Text("Error: $errorMessage", style: TextStyle(color: Colors.red)),
//           ],
//         ),
//       ),
//     );
//   }
// }
