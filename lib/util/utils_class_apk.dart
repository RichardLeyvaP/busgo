import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleGlobalApk {
  //fuentes
  // Define la fuente global en una variable
  static TextStyle globalTextStyle = GoogleFonts.poppins(); // Fuente que puede cambiarse fácilmente
  static TextStyle globalTitleApk = GoogleFonts.baloo2(); // Fuente que puede cambiarse fácilmente

  static TextStyle getStyleText() {
    return globalTextStyle;
  }

  static TextStyle getStyleTitleApk() {
    return globalTitleApk;
  }

  //
  //
  //
  //
  //colores
  static Color colorPrimary = const Color(0xFF007878);
  static Color colorIndicator = const Color.fromRGBO(255, 73, 73, 1.0);
  //nuevos
  static Color colorRedOpaque = const Color.fromARGB(255, 218, 113, 113);
  static Color colorOpaqueBlue = const Color.fromARGB(255, 93, 137, 233);
  static Color colorGreenBlue = const Color.fromARGB(255, 3, 98, 108);
  static Color colorDarkGreen = const Color.fromARGB(255, 3, 34, 33);
  static Color colorYellowBurnt = const Color.fromARGB(255, 228, 159, 57);
  //VARIABLES DE COLORES ACTUALES DEL SISTEMA
  static Color colorDarkBlue = const Color(0xFF000F81); //AZUL FUERTE
  static const Color colorDarkTeal = Color(0xFF032221); // #032221 VERDE OSCURO
static const Color colorSeaGreen = Color(0xFF03626C); // #03626C VERDE AZUL

static const Color colorSeaGreenClaro =  Color(0xFF02cc84a); // #03626C VERDE AZUL




  static Color getColorDarkBlue() {
    return colorDarkBlue; //color rojiso
  }

  static Color getColorDarkTeal() {
    return colorDarkTeal; //color rojiso
  }
  static Color getColorSeaGreen() {
    return colorSeaGreen; //color rojiso
  }



  static Color getColorIndicador() {
    return colorIndicator; //color rojiso
  }

  static Color getColorPrimary() {
    return colorPrimary; //color azul claro
  }

  static Color getColorRedOpaque() {
    return colorRedOpaque; //color azul claro
  }

  static Color getColorOpaqueBlue() {
    return colorOpaqueBlue; //color azul claro
  }

  static Color getColorGreenBlue() {
    return colorGreenBlue; //color azul claro
  }

  static Color getColorDarkGreen() {
    return colorDarkGreen; //color azul claro
  }

  static Color getColorYellowBurnt() {
    return colorYellowBurnt; //color azul claro
  }
}
