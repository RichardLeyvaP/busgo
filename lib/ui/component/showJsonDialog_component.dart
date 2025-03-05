import 'dart:convert';
import 'package:flutter/material.dart';

void showJsonDialog(BuildContext context, Map<String, dynamic> jsonResponse) {
  // Convertimos el JSON en una cadena formateada
  String jsonString = jsonEncode(jsonResponse);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Respuesta del Pago"),
        content: SingleChildScrollView(
          child: Text(jsonString, style: const TextStyle(fontSize: 14)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cerrar"),
          ),
        ],
      );
    },
  );
}
