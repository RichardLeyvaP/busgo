import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? color;
  final double? width;
  final double? height;
  final double? borderRadius;

  const CustomButton({
    required this.title,
    required this.onTap,
    this.color,
    this.width,
    this.height,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 120.0, // Valor predeterminado para el ancho
      height: height ?? 30.0, // Valor predeterminado para la altura
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.blue, // Color del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          elevation: 5, // Altura para el efecto de sombra
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
