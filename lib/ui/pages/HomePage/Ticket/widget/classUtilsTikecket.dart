import 'package:BusGo/data/services/local_database_service.dart';
import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/tickets_signals/tickets_service.dart';
import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/models/SeatModel.dart';
import 'package:BusGo/models/ticket/ticket_dabase_local/ticket_dabase_local_model.dart';
import 'package:BusGo/ui/component/internetConnectionModal_component.dart';
import 'package:BusGo/ui/component/showCustomSnackBar_component.dart';
import 'package:BusGo/ui/component/showJsonDialog_component.dart';
import 'package:BusGo/ui/pages/PrinterPage/widget/classUtilsPrinterTicketLocal.dart';
import 'package:BusGo/util/util_class_sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';
import 'package:intl/intl.dart';

import '../TicketPage.dart';

class UtilsTicket {
  List<Seat> generateSeats(int totalSeats, List<int> occupiedSeats) {
    List<Seat> seats = [];

    // Asientos hasta la penúltima fila (con pasillo en el medio)
    for (int i = 1; i <= totalSeats - 5; i += 4) {
      seats.add(Seat(number: i, isOccupied: occupiedSeats.contains(i)));
      seats.add(Seat(number: i + 1, isOccupied: occupiedSeats.contains(i + 1)));
      seats.add(Seat(number: -1, isOccupied: false)); // Representa el pasillo
      seats.add(Seat(number: i + 2, isOccupied: occupiedSeats.contains(i + 2)));
      seats.add(Seat(number: i + 3, isOccupied: occupiedSeats.contains(i + 3)));
    }

    // Última fila sin pasillo, con los asientos completos
    if (totalSeats > 20) {
      for (int i = totalSeats - 5 + 1; i <= totalSeats; i++) {
        // Ajuste aquí para empezar en 21
        seats.add(Seat(number: i, isOccupied: occupiedSeats.contains(i)));
      }
    }

    return seats;
  }

  Future<void> verifyPurchaseTicketClass(BuildContext context, price) async {
    if (selectedSeatNumbersSN.value.length <= 0) //no hay asientos seleccionados
    {
      showCustomSnackBar(
          context: context,
          title: 'No hay asientos seleccionados', // Obligatorio
          backgroundColor: Colors.red);
    } else //td bien
    {
      double total =
          ((double.parse(price) / 2) * quantityMenoresSignal.watch(context)) +
              ((double.parse(price)) * quantitySignal.watch(context));

      Map<String, dynamic> jsonResponse = await handlePayment(
          total,
          -1, //cashback,
          48, //dteType,
          [], //customFields,
          0, //exemptAmount,
          null, //externalReferenceId,
          false, //flagAccountPayProvider,
          null, // idProviderAccount,
          0, // netAmount,
          "", // sourceName,
          "", // sourceVersion,
          "", // taxIdnValidation,
          -1, //installmentsQuantity,
          0, //method,
          false, //printVoucherOnApp,
          -1 //tip
          );

      // showJsonDialog(context, jsonResponse);
      handleResponse(jsonResponse, context, total, price);
      //SI TD ESTA BIEN
    }
  }

  final DatabaseHelper dbHelper =
      DatabaseHelper(); // Instancia de la base de datos
  SharedPreferencesStorage sharedPreferencesStorage =
      SharedPreferencesStorage(); // Instancia de la base de datos

  modalResponseConecction(BuildContext contextT) async {
    InternetConnectionModal.show(
      contextT,
      onPayWithCash: () async {
        // Lógica para pagar con efectivo
        print('TIENE CONEXION - NO, GUARDAR EN DB-LOCAL');
        // Si no hay conexión, guardamos el ticket en la base de datos local
        double total = ((double.parse(tripsSelectSignal.value!.price!) / 2) *
                quantityMenoresSignal.watch(contextT)) +
            ((double.parse(tripsSelectSignal.value!.price!)) *
                quantitySignal.watch(contextT));
        int branch_id = currentUserBranchLG.value!.id;
        int trip_id = tripsSelectSignal.value!.id!;
        int quantity = quantityMenoresSignal.value + quantitySignal.value;
        List<int> seats = selectedSeatNumbersSN.value;
        DateTime date = tripsSelectSignal.value!.date!;
        int adults = quantitySignal.value;
        int minors = quantityMenoresSignal.value;

//esta entrando a esteeeeeeee
        Ticket newTicket = Ticket(
          id: DateTime.now().millisecondsSinceEpoch,
          branchId: branch_id,
          tripId: trip_id,
          method: 'Efectivo',
          quantity: quantity,
          price: double.parse(tripsSelectSignal.value!.price!),
          seats: seats,
          date: DateFormat('yyyy-MM-dd').format(date),
          adults: adults,
          minors: minors,
          total: total,
          //estos estan ahi pero no se envian
          //************************* */
          status: 1,
          transactionStatus: 'pending',
          sequenceNumber: 'abc123',
          extraData: 'no extra data',
          transactionTip: 10.0,
          transactionCashback: 5.0,
          //************************* */
        );

        final resultTicket = await dbHelper.insertTicket(newTicket);
        if (resultTicket != null) {
          //Aumento la variable que me controla la cantidad de tickets guardados en la db-local
          sharedPreferencesStorage.incrementCounter();
          showCustomSnackBar(
              context: contextT,
              title:
                  'Compra de Ticket guardada correctamente db-Local', // Obligatorio
              backgroundColor: Colors.green);
          //Mandar a Imprimir
          UtilsPrinterTicketLocal utilsPrinterTicketLocal =
              UtilsPrinterTicketLocal();
          String scheduleActual = DateFormat('HH:mm').format(DateTime.now());
          await utilsPrinterTicketLocal.printTicketPasajeLocal(
              newTicket,
              scheduleActual,
              tripsSelectSignal.value!.origin.toString(),
              tripsSelectSignal.value!.destination.toString());
        } else {
          showCustomSnackBar(
              context: contextT,
              title: 'Error al guardar el Ticket', // Obligatorio
              backgroundColor: Colors.red);
        }
      },
      onCancel: () {
        // Lógica cuando se cancela
      },
    );
  }

  void handleResponse(Map<String, dynamic> jsonResponse, BuildContext contextT, double total, price) async {
    if (jsonResponse.containsKey("errorCode")) {
      int errorCode = jsonResponse["errorCode"];
      String errorMessage = jsonResponse["errorMessage"] ?? "Error desconocido";
      int errorCodeOnApp = jsonResponse["errorCodeOnApp"] ?? 0;
      String errorMessageOnApp = jsonResponse["errorMessageOnApp"] ?? "Error en la app";

      showCustomSnackBar(
        context: contextT,
        title: 'Error Code: $errorCode ,error mensaje: $errorMessage',
        titleColor: Colors.white,
        icon: Icons.error,
        backgroundColor: Colors.red,
        isPersistent: true,
        showAcceptButton: true,
      );
      modalResponseConecction(contextT);
      return;
    }

    if (jsonResponse.containsKey("error")) {
      showCustomSnackBar(
        context: contextT,
        title: 'Error: mensaje de error: ${jsonResponse["error"]}',
        titleColor: Colors.white,
        icon: Icons.error,
        backgroundColor: Colors.red,
        isPersistent: true,
        showAcceptButton: true,
      );
      modalResponseConecction(contextT);
      return;
    }

    if (jsonResponse.containsKey("transactionStatus")) {
      bool transactionStatus = jsonResponse["transactionStatus"] ?? false;
      String sequenceNumber = jsonResponse["sequenceNumber"] ?? "";
      bool printerVoucherCommerce = jsonResponse["printerVoucherCommerce"] ?? false;
      dynamic transactionTip = jsonResponse["transactionTip"];
      Map<String, dynamic>? extraData = jsonResponse["extraData"];

      showCustomSnackBar(
        context: contextT,
        title: "Pago exitoso: sequenceNumber: $sequenceNumber",
        titleColor: Colors.white,
        icon: Icons.check_circle,
        backgroundColor: Colors.green,
        isPersistent: false,
      );

      int branch_id = currentUserBranchLG.value!.id;
      int trip_id = tripsSelectSignal.value!.id!;
      int quantity = quantityMenoresSignal.value + quantitySignal.value;
      List<int> seats = selectedSeatNumbersSN.value;
      DateTime date = tripsSelectSignal.value!.date!;
      int adults = quantitySignal.value;
      int minors = quantityMenoresSignal.value;

      // Guardar en la base de datos (probablemente en línea)
      await storeTrip(
        branch_id,
        trip_id,
        'Tarjeta', // Método de pago
        'success', // Estado
        quantity,
        price,
        total,
        seats,
        date,
        adults,
        minors,
        transactionStatus,
        sequenceNumber,
        extraData,
        transactionTip,
        'transactionCashback',
      );

      // 🖨️ Imprimir ticket
      String scheduleActual = DateFormat('HH:mm').format(DateTime.now());
      Ticket ticket = Ticket(
        id: DateTime.now().millisecondsSinceEpoch,
        branchId: branch_id,
        tripId: trip_id,
        method: 'Tarjeta',
        quantity: quantity,
        price: double.parse(price),
        seats: seats,
        date: DateFormat('yyyy-MM-dd').format(date),
        adults: adults,
        minors: minors,
        total: total,
        status: 1,
        transactionStatus: 'success',
        sequenceNumber: sequenceNumber,
        extraData: extraData?.toString() ?? '',
        transactionTip: transactionTip is double ? transactionTip : 0.0,
        transactionCashback: 0.0,
      );

      await utilsPrinterTicketLocal.printTicketPasajeLocal(
        ticket,
        scheduleActual,
        tripsSelectSignal.value!.origin.toString(),
        tripsSelectSignal.value!.destination.toString(),
      );

      // 🧭 Volver a la pantalla de selección de viajes
      // GoRouter.of(contextT).go('/DashboardPage');
      GoRouter.of(contextT).go('/SalesPage');

    } else {
      showCustomSnackBar(
        context: contextT,
        title: "⚠️ Respuesta desconocida: $jsonResponse",
        titleColor: Colors.white,
        icon: Icons.warning,
        backgroundColor: Colors.orange,
        isPersistent: true,
        showAcceptButton: true,
      );
      modalResponseConecction(contextT);
    }
  }

}
