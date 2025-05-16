import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String title,
  Color titleColor = Colors.white,
  IconData? icon,
  Color backgroundColor = Colors.black,
  Duration duration = const Duration(seconds: 2),
  bool isPersistent = false, // Opción para que no se cierre automáticamente
  bool showAcceptButton = false, // Opción para mostrar botón "Aceptar"
}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: titleColor), // Ícono personalizado
          const SizedBox(width: 8), // Espaciado entre el ícono y el texto
        ],
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: titleColor),
          ),
        ),
        if (showAcceptButton) // Muestra botón "Aceptar" solo si está activado
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: Text("Aceptar", style: TextStyle(color: titleColor)),
          ),
      ],
    ),
    backgroundColor: backgroundColor,
    duration: isPersistent ? const Duration(days: 1) : duration, // No se cierra si es persistente
    behavior: SnackBarBehavior.floating, // Para que flote en la pantalla
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
