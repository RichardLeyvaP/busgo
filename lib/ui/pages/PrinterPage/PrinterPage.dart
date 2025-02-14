// import 'dart:async';
// import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';


// class PrinterPage extends StatefulWidget {
//   @override
//   _PrinterPageState createState() => _PrinterPageState();
// }

// class _PrinterPageState extends State<PrinterPage> {
//   bool connected = false;
//   List availableBluetoothDevices = [];

//   Future<void> getBluetooth() async {
//    final List<dynamic> bluetooths = await BluetoothThermalPrinter.getBluetooths ?? [];
// setState(() {
//   availableBluetoothDevices = bluetooths;
// });

//   }

//   Future<void> setConnect(String mac) async {
//   try {
//     // Intentamos conectar con la impresora Bluetooth usando la dirección MAC
//     final String result = await BluetoothThermalPrinter.connect(mac)??"false";
    
//     // Comprobamos el resultado de la conexión
//     if (result == "true") {
//       setState(() {
//         connected = true; // Cambiar el estado de la conexión a true si es exitosa
//       });
//       print("Conexión exitosa");
//     } else {
//       // Si la conexión no fue exitosa
//       setState(() {
//         connected = false;
//       });
//       print("Fallo en la conexión");
//     }
//   } catch (e) {
//     // Captura cualquier error que pueda ocurrir (por ejemplo, un error de Bluetooth)
//     setState(() {
//       connected = false;
//     });
//     print("Error al intentar conectar: $e");
//   }
// }


// Future<void> printTicket() async {
//   String isConnected = await BluetoothThermalPrinter.connectionStatus ?? "false"; // Valor por defecto si es nulo
//   if (isConnected == "true") {
//     List<int> bytes = await getTicket();
//     final result = await BluetoothThermalPrinter.writeBytes(bytes);
//     print("Print $result");
//   } else {
//     print("Printer not connected");
//   }
// }


//   Future<List<int>> getTicket() async {
//     List<int> bytes = [];
//     CapabilityProfile profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm80, profile);

//     bytes += generator.text("Demo Shop", styles: PosStyles(align: PosAlign.center));
//     bytes += generator.text('Address: 18th Main Road, Bengaluru');
//     bytes += generator.hr();
//     bytes += generator.text('Item 1: Tea - 10');

//     bytes += generator.cut();
//     return bytes;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Bluetooth Thermal Printer Demo'),
//         ),
//         body: Container(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Search Paired Bluetooth"),
//               TextButton(
//                 onPressed: this.getBluetooth,
//                 child: Text("Search"),
//               ),
//               Container(
//                 height: 200,
//                 child: ListView.builder(
//                   itemCount: availableBluetoothDevices.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       onTap: () {
//                         String select = availableBluetoothDevices[index];
//                         List list = select.split("#");
//                         String mac = list[1];
//                         this.setConnect(mac);
//                       },
//                       title: Text('${availableBluetoothDevices[index]}'),
//                       subtitle: Text("Click to connect"),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 30),
//               TextButton(
//                 onPressed: connected ? this.printTicket : null,
//                 child: Text("Print Ticket"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
