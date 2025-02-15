import 'package:BusGo/ui/pages/PrinterPage/widget/classUtilsPrinterTicket.dart';
import 'package:flutter/material.dart'; 

class PrintTicketPage extends StatelessWidget {
   PrintTicketPage({super.key});

final utilsPrinterTicket = UtilsPrinterTicket();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imprimir Reportes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: utilsPrinterTicket.printTicketPasaje,
              child: const Text('Imprimir Ticket de Pasaje'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: utilsPrinterTicket.printReporte1,
              child: const Text('Imprimir Reporte 1'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: utilsPrinterTicket.printReporte2,
              child: const Text('Imprimir Reporte 2'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: utilsPrinterTicket.printReporte3,
              child: const Text('Imprimir Reporte 3'),
            ),
          ],
        ),
      ),
    );
  }
}




























//CODIGO FUNCIONANDO
// import 'package:flutter/material.dart';
// import 'package:sunmi_printer_plus/core/enums/enums.dart';
// import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';
// import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
// import 'package:sunmi_printer_plus/core/types/sunmi_column.dart';

// class PrintTicketPage extends StatelessWidget {
//   const PrintTicketPage({super.key});

//   // Método para imprimir el ticket de venta
//   Future<void> _printTicket() async {
//     try {
//       // Inicializa la impresora
//       await SunmiPrinter.initPrinter();
      
//       await SunmiPrinter.startTransactionPrint(true);

//       // Imprime el encabezado del ticket
//       await SunmiPrinter.printText(
//         'Ticket de Venta',
//         style: SunmiTextStyle(
//           bold: true,
//           align: SunmiPrintAlign.CENTER,
//           fontSize: 24,
//         ),
//       );

//       await SunmiPrinter.lineWrap(1); // Salto de línea

//       // Imprime la fecha y hora
//       final now = DateTime.now();
//       await SunmiPrinter.printText(
//         'Fecha: ${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}',
//         style: SunmiTextStyle(
//           align: SunmiPrintAlign.CENTER,
//         ),
//       );

//       await SunmiPrinter.line(); // Línea divisoria
//       await SunmiPrinter.lineWrap(1); // Salto de línea

//       // Imprime la tabla de productos
//       await SunmiPrinter.printRow(cols: [
//         SunmiColumn(text: 'Producto', width: 12),
//         SunmiColumn(text: 'Cantidad', width: 6),
//         SunmiColumn(text: 'Precio', width: 6),
//         SunmiColumn(text: 'Total', width: 6),
//       ]);

//       // Ejemplo de productos
//       final products = [
//         {'name': 'Producto 1', 'quantity': '2x', 'price': '10.00', 'total': '20.00'},
//         {'name': 'Producto 2', 'quantity': '1x', 'price': '15.00', 'total': '15.00'},
//         {'name': 'Producto 3', 'quantity': '3x', 'price': '5.00', 'total': '15.00'},
//       ];

//       for (var product in products) {
//         await SunmiPrinter.printRow(cols: [
//           SunmiColumn(text: product['name']!, width: 12),
//           SunmiColumn(text: product['quantity']!, width: 6),
//           SunmiColumn(text: product['price']!, width: 6),
//           SunmiColumn(text: product['total']!, width: 6),
//         ]);
//       }

//       await SunmiPrinter.line(); // Línea divisoria
//       await SunmiPrinter.lineWrap(1); // Salto de línea

//       // Imprime el total
//       await SunmiPrinter.printRow(cols: [
//         SunmiColumn(text: 'TOTAL', width: 24, style: SunmiTextStyle(bold: true)),
//         SunmiColumn(text: '50.00', width: 6, style: SunmiTextStyle(bold: true)),
//       ]);

//       await SunmiPrinter.lineWrap(2); // Salto de línea

//       // Imprime un mensaje de agradecimiento
//       await SunmiPrinter.printText(
//         '¡Gracias por su compra!',
//         style: SunmiTextStyle(
//           align: SunmiPrintAlign.CENTER,
//           bold: true,
//         ),
//       );

//       await SunmiPrinter.lineWrap(3); // Salto de línea
//       await SunmiPrinter.cutPaper(); // Cortar papel (si la impresora lo soporta)

//       // Finaliza la transacción de impresión
//       await SunmiPrinter.exitTransactionPrint(true);
//     } catch (e) {
//       print('Error al imprimir: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Imprimir Ticket de Venta'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Presiona el botón para imprimir un ticket de venta',
//               style: TextStyle(fontSize: 18),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _printTicket,
//               child: const Text('Imprimir Ticket'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }