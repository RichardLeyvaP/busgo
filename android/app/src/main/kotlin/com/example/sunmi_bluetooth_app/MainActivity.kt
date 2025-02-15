package com.example.BusGo

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.Log

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.app/payment_result"
    private val PAYMENT_REQUEST_CODE = 1001

    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            try {
                when (call.method) {
                    "startPayment" -> {
                        val jsonData = call.argument<String>("paymentData")
                        pendingResult = result // Guardamos el resultado para retornarlo después
                        startPaymentActivity(jsonData)
                    }
                    "getPaymentResult" -> {
                        pendingResult = result
                    }
                    "isAppInstalled" -> {
                        val packageName = call.argument<String>("packageName") ?: ""
                        val isInstalled = isAppInstalled(packageName)
                        result.success(isInstalled)
                    }
                    else -> result.notImplemented()
                }
            } catch (e: Exception) {
                Log.e("FlutterHaulmer", "Error en MethodChannel: ${e.message}")
                result.error("METHOD_ERROR", "Error en la comunicación con Flutter", null)
            }
        }
    }

    
    private fun isAppInstalled(packageName: String): Boolean {
        return try {
            packageManager.getPackageInfo(packageName, 0)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            Log.w("FlutterHaulmer", "App no instalada: $packageName")
            false
        } catch (e: Exception) {
            Log.e("FlutterHaulmer", "Error verificando instalación de app: ${e.message}")
            false
        }
    }

    private fun startPaymentActivity(jsonData: String?) {
        try {
            val packageManager = applicationContext.packageManager
            val sendIntent = packageManager.getLaunchIntentForPackage("com.haulmer.paymentapp.dev")

            if (sendIntent == null) {
                pendingResult?.error("UNAVAILABLE", "PAGO-DEV no encontrada", null)
                pendingResult = null
                return
            }

            sendIntent.action = Intent.ACTION_SEND
            sendIntent.type = "text/json"
            sendIntent.putExtra(Intent.EXTRA_TEXT, jsonData)

            startActivityForResult(sendIntent, PAYMENT_REQUEST_CODE) // ✅ Usamos startActivityForResult()

        } catch (e: Exception) {
            Log.e("FlutterHaulmer", "Error al iniciar la actividad de pago: ${e.message}")
            pendingResult?.error("ACTIVITY_ERROR", "No se pudo iniciar la actividad de pago", null)
            pendingResult = null
        }
    }



    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
    
        if (requestCode == PAYMENT_REQUEST_CODE) {
            if (pendingResult == null) return
    
            if (resultCode == Activity.RESULT_OK && data != null) {
                val resultJson = data.getStringExtra("resultJson")
                if (resultJson != null) {
                    pendingResult?.success(resultJson) // 🔥 Devuelve el JSON sin modificar
                } else {
                    pendingResult?.error("INVALID_RESPONSE", "Respuesta nula de la app de pago", null)
                }
            } else {
                pendingResult?.error("PAYMENT_CANCELED", "El usuario canceló el pago", null)
            }
            pendingResult = null
        }
    }
    

    // override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    //     super.onActivityResult(requestCode, resultCode, data)

    //     if (requestCode == PAYMENT_REQUEST_CODE) {
    //         if (pendingResult == null) return

    //         if (resultCode == Activity.RESULT_OK && data != null) {
    //             val resultJson = data.getStringExtra("resultJson")
    //             pendingResult?.success(
    //                 mapOf(
    //                     "success" to true,
    //                     "paymentRequestId" to resultJson,
    //                     "message" to "Pago completado exitosamente"
    //                 )
    //             )
    //         } else {
    //             pendingResult?.success(
    //                 mapOf(
    //                     "success" to false,
    //                     "errorCode" to "PAYMENT_CANCELED",
    //                     "message" to "El usuario canceló el pago"
    //                 )
    //             )
    //         }
    //         pendingResult = null
    //     }
    // }

}











