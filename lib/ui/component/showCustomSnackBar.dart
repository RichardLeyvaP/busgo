import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String title,
  Color titleColor = Colors.white,
  IconData? icon,
  Color backgroundColor = Colors.black,
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: titleColor), // Ícono personalizado
            SizedBox(width: 8), // Espaciado entre el ícono y el texto
          ],
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: titleColor),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor, // Fondo personalizado
      duration: duration, // Duración personalizada
    ),
  );
}
