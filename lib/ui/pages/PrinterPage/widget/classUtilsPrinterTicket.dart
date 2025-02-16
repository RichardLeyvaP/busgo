import 'dart:io';

import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/env.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;



class UtilsPrinterTicket {



// Método para descargar la imagen desde URL y luego imprimirla
  Future<void> printImageFromUrl(String imageUrl) async {
    try {
      // Descarga la imagen desde la URL
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Si la descarga es exitosa, obtiene los bytes
        Uint8List imageBytes = response.bodyBytes;

        // Imprime la imagen
        await SunmiPrinter.printImage(imageBytes);
        print('Imagen impresa correctamente');
      } else {
        print('Error al descargar la imagen');
      }
    } catch (e) {
      print('Error al imprimir la imagen: $e');
    }
  }

  
// Método para imprimir una imagen
Future<void> printImageFromFile(String imagePath) async {
  try {
    // Lee el archivo de la imagen
    File imageFile = File(imagePath);
    Uint8List imageBytes = await imageFile.readAsBytes();
     // Imprime el logo de la empresa
      await SunmiPrinter.printText(
  '',
  style: SunmiTextStyle(
    align: SunmiPrintAlign.CENTER,
  ),
);

    // Imprime la imagen
    await SunmiPrinter.printImage(imageBytes);
  } catch (e) {
    print('Error al imprimir la imagen: $e');
  }
}


      // currentUserLG.value = result; // Guardamos el usuario
      // //aqui para guardar la branch
      // currentUserBranchLG.value = currentUserLG.value?.branch;
      // //aqui para guardar la company
      // currentUserBranchCompanyLG.value = currentUserLG.value?.branch.company;

  // Método para imprimir el ticket de pasaje
  Future<void> printTicketPasaje() async {
    try {
      await SunmiPrinter.initPrinter();
      await SunmiPrinter.startTransactionPrint(true);
      
   String imageLogo = '${Env.apiEndpoint}/image/${currentUserBranchCompanyLG.value?.image}' ;   
   await printImageFromUrl(imageLogo);

      await SunmiPrinter.lineWrap(1); 

      // Imprime la información del ticket
      await SunmiPrinter.printText(currentUserBranchCompanyLG.value?.name??'-- No tiene --', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('RUT: ${currentUserBranchCompanyLG.value?.rut??'-- No tiene --'}', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('Dirección: ${currentUserBranchCompanyLG.value?.address??'-- No tiene --'}', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('Teléfono: ${currentUserBranchCompanyLG.value?.phone??'-- No tiene --'}', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('Folio N°99999', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.lineWrap(1); 

      await SunmiPrinter.printText('FECHA: 01/01/2024 HORA: 10:32', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('RECORRIDO:', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('ORIGEN: TERMINAL DE BUSES', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('DESTINO: AEROPUERTO EL TEPUAL', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Precio: \$6.500', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Medio de pago: Efectivo', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.lineWrap(1); 

      // Imprime el segundo ticket
      await SunmiPrinter.printText('- Copia de control -', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('N° 99999', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('FECHA: 01/01/2024 HORA: 10:32', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('RECORRIDO:', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('ORIGEN: TERMINAL DE BUSES', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('DESTINO: AEROPUERTO EL TEPUAL', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Precio: \$6.500', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.lineWrap(2); 

      await SunmiPrinter.cutPaper(); 
      await SunmiPrinter.exitTransactionPrint(true);
    } catch (e) {
      print('Error al imprimir ticket de pasaje: $e');
    }
  }

  // Método para imprimir reporte1
  Future<void> printReporte1() async {
    try {
      await SunmiPrinter.initPrinter();
      await SunmiPrinter.startTransactionPrint(true);
      
      
 String imageLogo = '${Env.apiEndpoint}/image/${currentUserBranchCompanyLG.value?.image}' ; 
await printImageFromUrl(imageLogo);

      // Imprime el reporte
      await SunmiPrinter.printText(currentUserBranchCompanyLG.value?.name??'-- No tiene --', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));await SunmiPrinter.printText('NOMBRE EMPRESA', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('FECHA: 01/01/2024', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('Sucursal: ${currentUserBranchLG.value?.name??'-- No tiene --'}', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.lineWrap(1);

      await SunmiPrinter.printText('RESUMEN:', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('EMISIÓN DE PASAJES', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Pasajes emitidos: 120', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Reimpresiones: 1', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('EFECTIVO: 20', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('DÉBITO: 70', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('CRÉDITO: 10', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('TOTALES:', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('EFECTIVO: \$45.500', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('DÉBITO: \$78.000', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('CRÉDITO: \$55.000', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('TOTAL: \$178.500', style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.lineWrap(2);

      await SunmiPrinter.cutPaper();
      await SunmiPrinter.exitTransactionPrint(true);
    } catch (e) {
      print('Error al imprimir reporte 1: $e');
    }
  }

 // Método para imprimir reporte2
Future<void> printReporte2() async {
  try {
    // Inicializa la impresora
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);

     
 String imageLogo = '${Env.apiEndpoint}/image/${currentUserBranchCompanyLG.value?.image}' ; 
await printImageFromUrl(imageLogo);

    // Imprime el encabezado del reporte
    await SunmiPrinter.printText(
      'NOMBRE EMPRESA',
      style: SunmiTextStyle(
        bold: true,
        align: SunmiPrintAlign.CENTER,
        fontSize: 24,
      ),
    );

    await SunmiPrinter.lineWrap(1); // Salto de línea

    // Imprime la fecha y sucursal
    await SunmiPrinter.printText(
      'FECHA: 01/01/2024\nSucursal: Terminal de buses 1',
      style: SunmiTextStyle(
        align: SunmiPrintAlign.CENTER,
      ),
    );

    await SunmiPrinter.line(); // Línea divisoria
    await SunmiPrinter.lineWrap(1); // Salto de línea

    // Imprime el resumen
    await SunmiPrinter.printText(
      'RESUMEN:\nEMISIÓN DE PASAJES\nPasajes emitidos: 120\nReimpresiones: 1\nEFECTIVO: 20\nDÉBITO: 70\nCRÉDITO: 10',
      style: SunmiTextStyle(
        align: SunmiPrintAlign.LEFT,
      ),
    );

    // Imprime los totales
    await SunmiPrinter.printText(
      'TOTALES:\n - EFECTIVO: \$45.500 - DÉBITO: \$78.000 - CRÉDITO: \$55.000\n - TOTAL: \$178.500',
      style: SunmiTextStyle(
        align: SunmiPrintAlign.LEFT,
      ),
    );

    await SunmiPrinter.line(); // Línea divisoria
    await SunmiPrinter.lineWrap(1); // Salto de línea

    // Imprime los tramos
    await SunmiPrinter.printText(
      'TRAMOS:',
      style: SunmiTextStyle(
        bold: true,
        align: SunmiPrintAlign.LEFT,
      ),
    );
    await SunmiPrinter.lineWrap(1); // Salto de línea

    // Imprime cada tramo
    final tramos = [
      {
        'name': 'TERMINAL DE BUSES – AEROPUERTO',
        'totalPasajes': 30,
        'efectivo': 10,
        'debito': 10,
        'credito': 10,
        'totalTramo': 100000,
        'efectivoTramo': 30000,
        'debitoTramo': 40000,
        'creditoTramo': 30000
      },
      {
        'name': 'TERMINAL DE BUSES – PUERTO VARAS',
        'totalPasajes': 30,
        'efectivo': 10,
        'debito': 10,
        'credito': 10,
        'totalTramo': 100000,
        'efectivoTramo': 30000,
        'debitoTramo': 40000,
        'creditoTramo': 30000
      },
      {
        'name': 'TERMINAL DE BUSES – PARTICULAR',
        'totalPasajes': 30,
        'efectivo': 10,
        'debito': 10,
        'credito': 10,
        'totalTramo': 100000,
        'efectivoTramo': 30000,
        'debitoTramo': 40000,
        'creditoTramo': 30000
      },
    ];

    for (var tramo in tramos) {
      await SunmiPrinter.printText(
        '${tramo['name']}\nTotal pasajes: ${tramo['totalPasajes']}\nEfectivo: ${tramo['efectivo']}\nDébito: ${tramo['debito']}\nCrédito: ${tramo['credito']}',
        style: SunmiTextStyle(
          align: SunmiPrintAlign.LEFT,
        ),
      );
      await SunmiPrinter.printText(
        'Total Tramo: \$${tramo['totalTramo']}\nEfectivo: \$${tramo['efectivoTramo']}\nDébito: \$${tramo['debitoTramo']}\nCrédito: \$${tramo['creditoTramo']}',
        style: SunmiTextStyle(
          align: SunmiPrintAlign.LEFT,
        ),
      );
      await SunmiPrinter.lineWrap(1); // Salto de línea
    }

    await SunmiPrinter.cutPaper(); // Cortar papel (si la impresora lo soporta)
    await SunmiPrinter.exitTransactionPrint(true); // Finaliza la transacción de impresión
  } catch (e) {
    print('Error al imprimir reporte 2: $e');
  }
}

// Método para imprimir reporte3
Future<void> printReporte3() async {
  try {
    // Inicializa la impresora
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);

      
 String imageLogo = '${Env.apiEndpoint}/image/${currentUserBranchCompanyLG.value?.image}' ; 
await printImageFromUrl(imageLogo);

    // Imprime el encabezado del reporte
    await SunmiPrinter.printText(
      'NOMBRE EMPRESA',
      style: SunmiTextStyle(
        bold: true,
        align: SunmiPrintAlign.CENTER,
        fontSize: 24,
      ),
    );

    await SunmiPrinter.lineWrap(1); // Salto de línea

    // Imprime la fecha y sucursal
    await SunmiPrinter.printText(
      'FECHA: 01/01/2024 – 31/01/2024\nSucursal: Terminal de buses 1',
      style: SunmiTextStyle(
        align: SunmiPrintAlign.CENTER,
      ),
    );

    await SunmiPrinter.line(); // Línea divisoria
    await SunmiPrinter.lineWrap(1); // Salto de línea

    // Imprime el resumen
    await SunmiPrinter.printText(
      'RESUMEN:\nEMISIÓN DE PASAJES\nPasajes emitidos: 1700\nReimpresiones: 3\nEFECTIVO: 500\nDÉBITO: 700\nCRÉDITO: 500',
      style: SunmiTextStyle(
        align: SunmiPrintAlign.LEFT,
      ),
    );

    // Imprime los totales
    await SunmiPrinter.printText(
      'TOTALES:\n - EFECTIVO: \$5.000.000 - DÉBITO: \$7.000.000 - CRÉDITO: \$5.000.000\n - TOTAL: \$17.000.000',
      style: SunmiTextStyle(
        align: SunmiPrintAlign.LEFT,
      ),
    );

    await SunmiPrinter.cutPaper(); // Cortar papel (si la impresora lo soporta)
    await SunmiPrinter.exitTransactionPrint(true); // Finaliza la transacción de impresión
  } catch (e) {
    print('Error al imprimir reporte 3: $e');
  }
}



}