import 'dart:io';

import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/reports_signals/reports_signals.dart';
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
      //final response = await http.get(Uri.parse('https://www.isdi.education/es/wp-content/uploads/2024/03/4312-modelos20de20negocio.jpg'));
      // final token = await getToken();
      //final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjozLCJlbWFpbCI6Imp1YW4ucGVyZXpAZXhhbXBsZS5jb20iLCJuYW1lIjoianVhbi5wZXJleiIsIndvcmtlciI6eyJpZCI6MiwibmFtZSI6Ikp1YW4gUMOpcmV6IiwiZW1haWwiOiJqdWFuLnBlcmV6QGV4YW1wbGUuY29tIiwiaW1hZ2UiOiJ3b3JrZXJzLzIuanBnIiwicm9sZV9pZCI6MSwicm9sZSI6eyJpZCI6MSwibmFtZSI6IkFkbWluaXN0cmFkb3IifSwiYnJhbmNoV29ya2VycyI6W3siaWQiOjEsImJyYW5jaF9pZCI6MSwid29ya2VyX2lkIjoyLCJyb2xlX2lkIjo1LCJjcmVhdGVkQXQiOiIyMDI1LTAxLTEwVDEzOjI1OjU3LjAwMFoiLCJ1cGRhdGVkQXQiOiIyMDI1LTAxLTE0VDEyOjE3OjAzLjAwMFoiLCJicmFuY2giOnsiaWQiOjEsImNvbXBhbnlfaWQiOjEsIm5hbWUiOiJTdWN1cnNhbCBkZSBQcnVlYmEiLCJpbWFnZSI6ImJyYW5jaGVzLzEuanBnIiwicnV0IjoiMzIuNTQ4Ljk2NS1rIiwiYWRkcmVzcyI6IkRpcmVjY2nDs24gZGUgU3VjdXJzYWwgZGUgUHJ1ZWJhIiwicGhvbmUiOiIrNTY5ODc0NTEyMzAiLCJjcmVhdGVkQXQiOiIyMDI1LTAxLTEwVDE0OjU4OjE4LjAwMFoiLCJ1cGRhdGVkQXQiOiIyMDI1LTAxLTEwVDE1OjExOjM1LjAwMFoiLCJjb21wYW55Ijp7ImlkIjoxLCJ1c2VyX2lkIjozLCJuYW1lIjoiTmVnb2NpbyBkZSBQcnVlYmEiLCJpbWFnZSI6ImNvbXBhbmllcy8xLnBuZyIsInJ1dCI6IjEyLjQ1Ni44NzYtOSIsImFkZH"; // Reemplaza con tu token real

      final response = await http.get(
        Uri.parse(imageUrl),
        headers: {
          'Authorization':
              'Bearer ${currentUserLG.value!.token}', // Enviar token en el encabezado
          'Accept': 'application/json', // Opcional
        },
      );
      print('Token de envio:${currentUserLG.value!.token}');

      if (response.statusCode == 200) {
        // Si la descarga es exitosa, obtiene los bytes
        Uint8List imageBytes = response.bodyBytes;

        // Imprime la imagen
        await SunmiPrinter.printImage(imageBytes);
        print('Imagen impresa correctamente');
      } else {
        print('Error al descargar la imagen-problema de token');
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

      String imageLogo =
          '${Env.apiEndpoint}/images/${currentUserBranchCompanyLG.value?.image}';
      await printImageFromUrl(imageLogo);
      await SunmiPrinter.lineWrap(1);

      // Imprime la información del ticket
      await SunmiPrinter.printText(
          currentUserBranchCompanyLG.value?.name ?? '-- No tiene --',
          style: SunmiTextStyle(
              align: SunmiPrintAlign.CENTER, fontSize: 24, bold: true));
      await SunmiPrinter.printText(
          'RUT: ${currentUserBranchCompanyLG.value?.rut ?? '-- No tiene --'}',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      // await SunmiPrinter.printText('Dirección: ${currentUserBranchCompanyLG.value?.address??'-- No tiene --'}', style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText(
          'Teléfono: ${currentUserBranchCompanyLG.value?.phone ?? '-- No tiene --'}',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('Boleta Electrónica  N° 340999',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.printText(
          'FECHA: ${resultReport1RP.value!.fecha} HORA: 12:25',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.printText('RECORRIDO:',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('ORIGEN: TERMINAL DE BUSES',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('DESTINO: AEROPUERTO EL TEPUAL',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Precio: \$6.500',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Medio de pago: Débito',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.lineWrap(1);
      //imprimir Qr
      String imageQR = '${Env.apiEndpoint}/images/qrscodes/10Qr.png';
      await printImageFromUrl(imageQR);

      await SunmiPrinter.lineWrap(2);
      //mandar a cortar
      await SunmiPrinter.cutPaper();
      await SunmiPrinter.lineWrap(1);
      // Imprime el segundo ticket
      await SunmiPrinter.printText('- Copia de control -',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('N° 99999',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('FECHA: 01/01/2024 HORA: 10:32',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('RECORRIDO:',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('ORIGEN: TERMINAL DE BUSES',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('DESTINO: AEROPUERTO EL TEPUAL',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Precio: \$6.500',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
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

      String imageLogo =
          '${Env.apiEndpoint}/images/${currentUserBranchCompanyLG.value?.image}';
      await printImageFromUrl(imageLogo);
      await SunmiPrinter.lineWrap(1);

      // Imprime el reporte
      await SunmiPrinter.printText(
          currentUserBranchCompanyLG.value?.name ?? '-- No tiene --',
          style: SunmiTextStyle(
              align: SunmiPrintAlign.CENTER, fontSize: 24, bold: true));
      await SunmiPrinter.printText('FECHA: ${resultReport1RP.value?.fecha ?? '-Sin fecha-'}',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText(
          'Sucursal: ${currentUserBranchLG.value?.name ?? '-- No tiene --'}',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.lineWrap(1);

      await SunmiPrinter.printText('RESUMEN:',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('EMISIÓN DE PASAJES',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText(
          'Pasajes emitidos: ${resultReport1RP.value?.pasajesEmitidos ?? 0}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText(
          'Reimpresiones: ${resultReport1RP.value?.reimpresiones ?? 0}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
 await SunmiPrinter.lineWrap(1);
      final totalesPorMetodos = resultReport1RP.value?.totalesPorMetodo;
      for (var totalesPorMetodo in totalesPorMetodos!) {
        await SunmiPrinter.printText('${totalesPorMetodo.metodo}: ${totalesPorMetodo.cantidad}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
        
      }
//una linea
 await SunmiPrinter.lineWrap(1);
 await SunmiPrinter.printText('TOTALES:',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
for (var totalesPorMetodo in totalesPorMetodos!) {
        await SunmiPrinter.printText('${totalesPorMetodo.metodo}: ${totalesPorMetodo.total}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
        
      }    
      await SunmiPrinter.printText('TOTAL: \$${resultReport1RP.value?.totales}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
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

      String imageLogo =
          '${Env.apiEndpoint}/images/${currentUserBranchCompanyLG.value?.image}';
      await printImageFromUrl(imageLogo);
      await SunmiPrinter.lineWrap(1);

      // Imprime el encabezado del reporte
      await SunmiPrinter.printText(
          currentUserBranchCompanyLG.value?.name ?? '-- No tiene --',
          style: SunmiTextStyle(
              align: SunmiPrintAlign.CENTER, fontSize: 24, bold: true));

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
      await SunmiPrinter.printText('RESUMEN:',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('EMISIÓN DE PASAJES',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.lineWrap(1); // Espaciado extra opcional

      await SunmiPrinter.printText('Pasajes emitidos: 120',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Reimpresiones: 1',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('EFECTIVO: 20',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('DÉBITO: 70',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('CRÉDITO: 10',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      // Imprime los totales
      await SunmiPrinter.printText('TOTALES:',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('- EFECTIVO: \$45.500',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('- DÉBITO: \$78.000',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('- CRÉDITO: \$55.000',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.lineWrap(1); // Espaciado extra opcional
      await SunmiPrinter.printText('- TOTAL: \$178.500',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

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
        await SunmiPrinter.printText('${tramo['name']}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

        await SunmiPrinter.printText('Total pasajes: ${tramo['totalPasajes']}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
        await SunmiPrinter.printText('Efectivo: ${tramo['efectivo']}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
        await SunmiPrinter.printText('Débito: ${tramo['debito']}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
        await SunmiPrinter.printText('Crédito: ${tramo['credito']}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

        await SunmiPrinter.lineWrap(1); // Espacio entre bloques

        await SunmiPrinter.printText('Total Tramo: \$${tramo['totalTramo']}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
        await SunmiPrinter.printText('Efectivo: \$${tramo['efectivoTramo']}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
        await SunmiPrinter.printText('Débito: \$${tramo['debitoTramo']}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
        await SunmiPrinter.printText('Crédito: \$${tramo['creditoTramo']}',
            style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

        await SunmiPrinter.lineWrap(
            2); // Salto de línea adicional para separación
      }

      await SunmiPrinter
          .cutPaper(); // Cortar papel (si la impresora lo soporta)
      await SunmiPrinter.exitTransactionPrint(
          true); // Finaliza la transacción de impresión
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

      String imageLogo =
          '${Env.apiEndpoint}/images/${currentUserBranchCompanyLG.value?.image}';
      await printImageFromUrl(imageLogo);
      await SunmiPrinter.lineWrap(1);

      // Imprime el encabezado del reporte
      await SunmiPrinter.printText(
          currentUserBranchCompanyLG.value?.name ?? '-- No tiene --',
          style: SunmiTextStyle(
              align: SunmiPrintAlign.CENTER, fontSize: 24, bold: true));

      await SunmiPrinter.lineWrap(1); // Salto de línea

      // Imprime la fecha y sucursal
      await SunmiPrinter.printText('FECHA: 01/01/2024 – 31/01/2024',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));

      await SunmiPrinter.printText('Sucursal: Terminal de buses 1',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));

      await SunmiPrinter.line(); // Línea divisoria
      await SunmiPrinter.lineWrap(1); // Salto de línea

      // Imprime el resumen
      await SunmiPrinter.printText('RESUMEN:',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.printText('EMISIÓN DE PASAJES',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.printText('Pasajes emitidos: 1700',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.printText('Reimpresiones: 3',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.printText('EFECTIVO: 500',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.printText('DÉBITO: 700',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.printText('CRÉDITO: 500',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      // Imprime los totales
      await SunmiPrinter.printText('TOTALES:',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.printText('- EFECTIVO: \$5.000.000',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.printText('- DÉBITO: \$7.000.000',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.printText('- CRÉDITO: \$5.000.000',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.printText('- TOTAL: \$17.000.000',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter
          .cutPaper(); // Cortar papel (si la impresora lo soporta)
      await SunmiPrinter.exitTransactionPrint(
          true); // Finaliza la transacción de impresión
    } catch (e) {
      print('Error al imprimir reporte 3: $e');
    }
  }
}
