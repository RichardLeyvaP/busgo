
import 'dart:convert';
import 'package:BusGo/ui/component/showCustomSnackBar.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentScreenNative extends StatefulWidget {
  @override
  _PaymentScreenNativeState createState() => _PaymentScreenNativeState();
}

class _PaymentScreenNativeState extends State<PaymentScreenNative> {
  static const platform = MethodChannel('com.example.app/payment_result');

  final TextEditingController amountController = TextEditingController();
  final TextEditingController tipController = TextEditingController();
  final TextEditingController cashbackController = TextEditingController();
  final TextEditingController installmentsController = TextEditingController();
  final TextEditingController taxIdController = TextEditingController();
  final TextEditingController exemptAmountController = TextEditingController();
  final TextEditingController netAmountController = TextEditingController();
  final TextEditingController sourceNameController = TextEditingController();
  final TextEditingController sourceVersionController = TextEditingController();

  int selectedPaymentMethod = 1;
  int selectedDteType = 0;

  String? transactionStatus;
  String? errorMessage;

  void onSendClick() {
    if (processPaymentData()) {
      showCustomSnackBar(
        context: context,
        title: "Enviando datos de pago...",
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      );
      debugPrint("Datos de pago válidos. Iniciando proceso de pago...");
    } else {
      showCustomSnackBar(
        context: context,
        title: "Datos de pago no válidos",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
      debugPrint("Datos de pago no válidos. No se puede proceder.");
    }
  }

  bool processPaymentData() {
    try {
      int amount = int.tryParse(amountController.text) ?? 0;
      int tip = int.tryParse(tipController.text) ?? 0;
      int cashback = int.tryParse(cashbackController.text) ?? 0;
      int installments = int.tryParse(installmentsController.text) ?? 0;
      String taxId = taxIdController.text;
      int exemptAmount = int.tryParse(exemptAmountController.text) ?? 0;
      int netAmount = int.tryParse(netAmountController.text) ?? 0;
      String sourceName = sourceNameController.text;
      String sourceVersion = sourceVersionController.text;

      Map<String, dynamic> requestData = {
        "amount": amount,
        "tip": tip,
        "cashback": cashback,
        "paymentMethod": selectedPaymentMethod,
        "installments": installments,
        "dteType": selectedDteType,
        "taxId": taxId,
        "exemptAmount": exemptAmount,
        "netAmount": netAmount,
        "sourceName": sourceName,
        "sourceVersion": sourceVersion,
        "customFields": []
      };

      sendPaymentIntent(requestData);
      return true;
    } catch (e) {
      showCustomSnackBar(
        context: context,
        title: "Datos de pago inválidos",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
      debugPrint("Error en processPaymentData: $e");
      return false;
    }
  }

void sendPaymentIntent(Map<String, dynamic> requestData) async {
  // 1. Verificar si la app de pago está instalada
  bool isAppInstalled = await isPaymentAppInstalled("com.haulmer.paymentapp.dev");
  if (!isAppInstalled) {
    showCustomSnackBar(
      context: context,
      title: "La app de pagos no está instalada",
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    );
    debugPrint("PAGO-DEV no encontrada");
    return;
  }

  // 2. Verificar si la actividad está en estado adecuado para enviar el intent
 /* if (isFinishing() || isDestroyed()) {
    debugPrint("La actividad está finalizando o ya ha sido destruida. No se puede enviar el intent.");
    return;
  }*/
final requestData = {
  "amount": 10000,
  "tip": 200,
  "cashback": 0,
  "method": 0,
  "installmentsQuantity": 0,
  "printVoucherOnApp": true,
  "dteType": 48,
  "extraData": {
    "taxIdnValidation": "76539108-3",
    "exemptAmount": 0,
    "netAmount": 200,
    "sourceName": "Tuu Demo",
    "sourceVersion": "1.1.1",
    "customFields": []
  }
};




try {
  final result = await platform.invokeMethod('startPayment', {'paymentData': jsonEncode(requestData)});
  print("Tipo de respuesta: ${result.runtimeType}"); // Verifica si es String o Map
  
  if (result is String) {
    final Map<String, dynamic> response = jsonDecode(result);
    print("Respuesta decodificada: $response");
  } else if (result is Map) {
    print("Respuesta ya es un mapa: $result");
  }
} catch (e) {
  print('Error al procesar el pago: $e');
}


}



void sendPaymentIntentClick() async {
  // 1. Verificar si la app de pago está instalada
  bool isAppInstalled = await isPaymentAppInstalled("com.haulmer.paymentapp.dev");
  if (!isAppInstalled) {
    showCustomSnackBar(
      context: context,
      title: "La app de pagos no está instalada",
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    );
    debugPrint("PAGO-DEV no encontrada");
    return;
  }

  // 2. Verificar si la actividad está en estado adecuado para enviar el intent
 /* if (isFinishing() || isDestroyed()) {
    debugPrint("La actividad está finalizando o ya ha sido destruida. No se puede enviar el intent.");
    return;
  }*/

  final requestData = {
    "amount": 10000,
    "cashback": -1,
    "dteType": 48,
    "extraData": {
      "customFields": [],
      "exemptAmount": 0,
      "externalReferenceId": null,
      "flagAccountPayProvider": false,
      "idProviderAccount": null,
      "netAmount": 0,
      "sourceName": "",
      "sourceVersion": "",
      "taxIdnValidation": ""
    },
    "installmentsQuantity": -1,
    "method": 0,
    "printVoucherOnApp": false,
    "tip": -1
  };

  // Convertir el mapa a una cadena JSON
  String varTest = jsonEncode(requestData);
       
  print(varTest); // Esto imprimirá la versión en JSON del requestData
  print('*****************************'); // Esto imprimirá la versión en JSON del requestData



try {
  final result = await platform.invokeMethod('startPayment', {'paymentData': varTest});
  print("Tipo de respuesta: ${result.runtimeType}"); // Verifica si es String o Map
  
  if (result is String) {
    final Map<String, dynamic> response = jsonDecode(result);
    print("Respuesta decodificada: $response");
  } else if (result is Map) {
    print("Respuesta ya es un mapa: $result");
  }
} catch (e) {
  print('Error al procesar el pago: $e');
}


}


Future<bool> isPaymentAppInstalled(String packageName) async {
  const platform = MethodChannel('com.example.app/payment_result');
   try {
    final bool isInstalled = await platform.invokeMethod('isAppInstalled', {
      "packageName": packageName,
    });
    return isInstalled;
  } on PlatformException catch (e) {
    debugPrint("Error al verificar instalación: $e");
    return false;
  }
}

bool isFinishing() {
  // Aquí podrías agregar alguna lógica para verificar el estado de la actividad.
  return false; // Ajusta según tu caso.
}

bool isDestroyed() {
  // Aquí podrías agregar alguna lógica para verificar si la actividad está destruida.
  return false; // Ajusta según tu caso.
}

Future<void> _getPaymentResult() async {
  await Future.delayed(Duration(seconds: 2)); // Espera antes de obtener el resultado

  try {
    final result = await platform.invokeMethod('getPaymentResult');

    if (result != null) {
      Map<String, dynamic> response = jsonDecode(jsonEncode(result));
      setState(() {
        transactionStatus = response["transactionStatus"] == true ? "Éxito" : "Fallido";
        errorMessage = response["errorMessage"];
      });
    }
  } catch (e) {
    showCustomSnackBar(
      context: context,
      title: "Error al obtener el resultado del pago",
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    );
    debugPrint("Error al obtener el resultado del pago: $e");
    setState(() {
      errorMessage = "Error al obtener el resultado del pago";
    });
  }
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BusGo - Pago")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // TextField(controller: amountController, decoration: InputDecoration(labelText: "Monto")),
              // TextField(controller: tipController, decoration: InputDecoration(labelText: "Propina")),
              // TextField(controller: cashbackController, decoration: InputDecoration(labelText: "Cashback")),
              // TextField(controller: installmentsController, decoration: InputDecoration(labelText: "Cuotas")),
              // TextField(controller: taxIdController, decoration: InputDecoration(labelText: "RUT/CPF/NIT")),
              // TextField(controller: exemptAmountController, decoration: InputDecoration(labelText: "Monto Exento")),
              // TextField(controller: netAmountController, decoration: InputDecoration(labelText: "Monto Neto")),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: sendPaymentIntentClick,
                  child: Text("Enviar Pago - Haulmer"),
                ),
              ),
              SizedBox(height: 20),
              if (transactionStatus != null)
                Text("Estado: $transactionStatus", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (errorMessage != null)
                Text("Error: $errorMessage", style: TextStyle(color: Colors.red)),
            ],
          ),
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
