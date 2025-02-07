import 'package:BusGo/util/HaulmerPayment/haulmerPayment%20_http.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
 

  // Datos dinámicos del pago
  double amount = 3000;
  String description = "Servicio de afiliación";
  int dteType = 48;
  String contact = "9 51221345";
  String sourceName = "POS Pagos";
  String sourceVersion = "v1.17v0.2";
  String deviceId = "TJ44245N20440";

   late HaulmerPayment paymentService;

  @override
  void initState() {
    super.initState();
    paymentService = HaulmerPayment(
      apiKey: "TU_API_KEY",
      deviceId: deviceId,
    );
  }

  void _handlePayment() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator(color: Colors.cyan,)),
    );

    final result = await paymentService.startPayment(
      amount: amount,
      description: description,
      dteType: dteType,
      contact: contact,
      sourceName: sourceName,
      sourceVersion: sourceVersion,
      
    );

    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result["success"] ? "Pago Exitoso" : "Error en el Pago"),
        content: Text(result["message"]),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pago con Haulmer")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Device ID"),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() => deviceId = value ),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Monto"),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() => amount = double.tryParse(value) ?? 3000),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Descripción"),
              onChanged: (value) => setState(() => description = value),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Contacto"),
              onChanged: (value) => setState(() => contact = value),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handlePayment,
              child: Text("Pagar"),
            ),
          ],
        ),
      ),
    );
  }
}
