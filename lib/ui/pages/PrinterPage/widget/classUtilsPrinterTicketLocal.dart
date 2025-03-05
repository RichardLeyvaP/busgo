import 'dart:io';

import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/reports_signals/reports_signals.dart';
import 'package:BusGo/env.dart';
import 'package:BusGo/models/ticket/ticket_dabase_local/ticket_dabase_local_model.dart';
import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

class UtilsPrinterTicketLocal {
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
  Future<void> printTicketPasajeLocal(Ticket ticket,schedule,tripOrigin,tripDestination) async {
    try {
      await SunmiPrinter.initPrinter();
      await SunmiPrinter.startTransactionPrint(true);
 final qrImage = await _generateQRImage(ticket.id!.toString());

       String imageLogo =
          '${Env.apiEndpoint}/images/${currentUserBranchCompanyLG.value?.image}';
      await printImageFromUrl(imageLogo);
      //await SunmiPrinter.printImage(qrImage); // Imprimir la imagen del QR
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
      // await SunmiPrinter.printText('Boleta Electrónica  N° 340999',
      //     style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.printText(
          'FECHA: ${resultReport1RP.value!.fecha} HORA: ${schedule}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.printText('RECORRIDO:',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('ORIGEN: ${tripOrigin}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('DESTINO: ${tripDestination}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Precio: \$${ticket.price}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Medio de pago: ${ticket.method}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.lineWrap(1);
      //imprimir Qr
     // String imageQR = '${Env.apiEndpoint}/images/${ticket.barcode}';
      await printImageFromUrl(qrImage.toString());

      await SunmiPrinter.lineWrap(2);
      //mandar a cortar
      await SunmiPrinter.cutPaper();
      await SunmiPrinter.lineWrap(1);
      // Imprime el segundo ticket
      await SunmiPrinter.printText('- Copia de control -',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('N° 99999',
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText('FECHA: ${ticket.date} HORA: ${schedule}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('RECORRIDO:',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('ORIGEN: ${tripOrigin}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('DESTINO: ${tripDestination}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.printText('Precio: \$${ticket.price}',
          style: SunmiTextStyle(align: SunmiPrintAlign.LEFT));
      await SunmiPrinter.lineWrap(2);

      await SunmiPrinter.cutPaper();

      await SunmiPrinter.exitTransactionPrint(true);
    } catch (e) {
      print('Error al imprimir ticket de pasaje: $e');
    }
  }



 Future<Uint8List> _generateQRImage(String data) async {
    final qrPainter = QrPainter(
      data: data,
      version: QrVersions.auto,
      color: Colors.black,
      emptyColor: Colors.white,
    );

    // Convertir el código QR en una imagen
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    qrPainter.paint(canvas, const Size(200, 200)); // Tamaño del QR
    final picture = recorder.endRecording();
    final image = await picture.toImage(200, 200); // Tamaño de la imagen
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List(); // Convertir a Uint8List
  }

}
