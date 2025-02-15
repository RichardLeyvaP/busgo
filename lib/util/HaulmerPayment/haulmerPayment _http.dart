import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HaulmerPayment {
  final String apiKey;
  final String deviceId;

  HaulmerPayment({required this.apiKey, required this.deviceId});

  static const platform = MethodChannel('com.example.app/payment_result');

  Future<bool> isPaymentAppInstalled(String packageName) async {
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

   Future<Map<String, dynamic>> sendPaymentIntentClick(
      amount,
      cashback,
      dteType,
      customFields,
      exemptAmount,
      externalReferenceId,
      flagAccountPayProvider,
      idProviderAccount,
      netAmount,
      sourceName,
      sourceVersion,
      taxIdnValidation,
      installmentsQuantity,
      method,
      printVoucherOnApp,
      tip) async {
    // 1. Verificar si la app de pago está instalada
    bool isAppInstalled =
        await isPaymentAppInstalled("com.haulmer.paymentapp.dev");
    if (!isAppInstalled) {
      debugPrint("PAGO-DEV no encontrada");
       return {
        "success": false,
        "errorCode": "UNEXPECTED_ERROR",
        "message": "PAGO-DEV no encontrada",
      };
    }

    // 2. Verificar si la actividad está en estado adecuado para enviar el intent
    /* if (isFinishing() || isDestroyed()) {
    debugPrint("La actividad está finalizando o ya ha sido destruida. No se puede enviar el intent.");
    return;
  }*/

    final requestData = {
      "amount": amount,
      "cashback": cashback,
      "dteType": dteType,
      "extraData": {
        "customFields": customFields,
        "exemptAmount": exemptAmount,
        "externalReferenceId": externalReferenceId,
        "flagAccountPayProvider": flagAccountPayProvider,
        "idProviderAccount": idProviderAccount,
        "netAmount": netAmount,
        "sourceName": sourceName,
        "sourceVersion": sourceVersion,
        "taxIdnValidation": taxIdnValidation
      },
      "installmentsQuantity": installmentsQuantity,
      "method": method,
      "printVoucherOnApp": printVoucherOnApp,
      "tip": tip
    };

    // final requestData = {
    //   "amount": 10000,
    //   "cashback": -1,
    //   "dteType": 48,
    //   "extraData": {
    //     "customFields": [],
    //     "exemptAmount": 0,
    //     "externalReferenceId": null,
    //     "flagAccountPayProvider": false,
    //     "idProviderAccount": null,
    //     "netAmount": 0,
    //     "sourceName": "",
    //     "sourceVersion": "",
    //     "taxIdnValidation": ""
    //   },
    //   "installmentsQuantity": -1,
    //   "method": 0,
    //   "printVoucherOnApp": false,
    //   "tip": -1
    // };

    // Convertir el mapa a una cadena JSON
    String dataSend = jsonEncode(requestData);

   try {
  final result = await platform.invokeMethod('startPayment', {'paymentData': dataSend});
  print("Tipo de respuesta: ${result.runtimeType}"); // Verifica si es String o Map


  if (result != null) {
  try {
    final Map<String, dynamic> jsonResponse = jsonDecode(result);
    if (jsonResponse.containsKey('transactionStatus')) {

  Map<String, dynamic> jsonResponse = Map<String, dynamic>.from(result);
  return jsonResponse;

    }  else {
   return {"error": "La respuesta del pago fue null"};
    }
  } catch (e) {
    
    print("Error al procesar la respuesta: $e");
    return {"error": "La respuesta del pago entro en el catch:$e"};
  }
} else {
  return {"error": "La respuesta del pago fue null"};
}




 
} on PlatformException catch (e) {
  print("Error en el método nativo: ${e.message}");
  return {"error": "Error en el método nativo: ${e.message}"};
  
} on MissingPluginException catch (e) {
  print("Método nativo no encontrado: ${e.message}");
 return {"error": "Método nativo no encontrado: ${e.message}"};
} catch (e) {
  print("Error inesperado: $e");
   return {"error": "Error inesperado: $e"};
} finally {
  print("Finalizando ejecución");
}


  }
}
