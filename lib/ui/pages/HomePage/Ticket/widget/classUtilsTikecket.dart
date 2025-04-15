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

import '../../../../../util/HaulmerPayment/haulmerPayment _http.dart';

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

  Future<void> verifyPurchaseTicketClass(BuildContext context, price,
      {required String paymentMethod}) async {
    if (selectedSeatNumbersSN.value.isEmpty) //no hay asientos seleccionados
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

      int paymentMethodCode = 0; // Valor por defecto para efectivo
      if (paymentMethod == 'Crédito') {
        paymentMethodCode = 1;
      } else if (paymentMethod == 'Débito') {
        paymentMethodCode = 2;
      }

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
          paymentMethodCode,
          false, //printVoucherOnApp,
          -1 //tip
          );

      // showJsonDialog(context, jsonResponse);
      handleResponse(jsonResponse, context, total, price, paymentMethod: '');
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

  void handleResponse(
      Map<String, dynamic> jsonResponse,
      BuildContext contextT,
      double total,
      String price, {
        required String paymentMethod,
      }) {
    try {
      if (jsonResponse.containsKey('errorCode') || jsonResponse.containsKey('error')) {
        _handleErrorResponse(jsonResponse, contextT);
        return;
      }

      if (jsonResponse.containsKey('transactionStatus')) {
        // 1. Extraer solo datos esenciales
        final transactionStatus = jsonResponse["transactionStatus"] ?? false;
        final sequenceNumber = jsonResponse["sequenceNumber"]?.toString() ?? 'N/A';
        final status = transactionStatus ? 'completed' : 'failed';

        // 2. Actualizar llamada a _storeTransaction
        _storeTransaction(
          context: contextT,
          paymentMethod: paymentMethod,
          status: status,
          sequenceNumber: sequenceNumber,
          total: total,
          price: price,
        );

        // 3. Manejar UI
        if (transactionStatus) {
          _showSuccessFeedback(contextT, sequenceNumber);
          _navigateToDashboard(contextT);
        } else {
          _showTransactionFailed(contextT);
        }

      } else {
        _handleUnknownResponse(jsonResponse, contextT);
      }
    } catch (e) {
      _handleGenericError(contextT, e);
    } finally {
      isLoadingSignalPR.value = false;
    }
  }

  void _showSuccessFeedback(BuildContext context, String transactionId) {
    showCustomSnackBar(
      context: context,
      title: 'Pago exitoso • N° $transactionId',
      backgroundColor: Colors.green,
    );
  }

  void _showTransactionFailed(BuildContext context) {
    showCustomSnackBar(
      context: context,
      title: 'Transacción rechazada',
      backgroundColor: Colors.red,
    );
  }

  void _navigateToDashboard(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      GoRouter.of(context).go('/DashboardPage');
      _resetTransactionState();
    });
  }

  void _handleErrorResponse(
      Map<String, dynamic> response, BuildContext context) {
    final errorCode = response['errorCode'] ?? 'N/A';
    final errorMessage =
        response['errorMessage'] ?? response['error'] ?? 'Error desconocido';
    final errorCodeOnApp = response['errorCodeOnApp'] ?? 0;

    submitErrorSignal.value =
        'Código: $errorCode ($errorCodeOnApp) - $errorMessage';

    showCustomSnackBar(
      context: context,
      title: 'Error en la transacción: $errorMessage',
      titleColor: Colors.white,
      icon: Icons.error_outline,
      backgroundColor: Colors.red,
      isPersistent: true,
      showAcceptButton: true,
    );

    modalResponseConecction(context);
  }

  void _handleSuccessResponse(
    Map<String, dynamic> response,
    BuildContext context,
    double total,
    String price,
    String paymentMethod,
  ) {
    final transactionStatus = response['transactionStatus'] ?? false;
    final sequenceNumber = response['sequenceNumber']?.toString() ?? '';
    final printerVoucherCommerce = response['printerVoucherCommerce'] ?? false;
    final transactionTip = response['transactionTip'] ?? 0.0;
    final extraData = response['extraData'] as Map<String, dynamic>?;

    // Actualizar estado de la UI
    productSubmittedSuccessSignal.value = true;

    // Guardar en base de datos
    _storeTransaction(
      context: context,
      paymentMethod: paymentMethod,
      status: transactionStatus ? 'completed' : 'pending',
      sequenceNumber: sequenceNumber,
      total: total,
      price: price,
    );

    // Mostrar feedback al usuario
    showCustomSnackBar(
      context: context,
      title: 'Pago exitoso • N° $sequenceNumber',
      titleColor: Colors.white,
      icon: Icons.check_circle,
      backgroundColor: Colors.green,
    );

    // Navegar y resetear estado
    Future.delayed(const Duration(seconds: 2), () {
      GoRouter.of(context).go('/DashboardPage');
      _resetTransactionState();
    });
  }

  void _handleUnknownResponse(
      Map<String, dynamic> response, BuildContext context) {
    debugPrint('⚠️ Respuesta desconocida: $response');
    submitErrorSignal.value = 'Respuesta inesperada del servidor';

    showCustomSnackBar(
      context: context,
      title: 'Respuesta inesperada del sistema',
      titleColor: Colors.white,
      icon: Icons.warning_amber_rounded,
      backgroundColor: Colors.orange,
      isPersistent: true,
      showAcceptButton: true,
    );

    modalResponseConecction(context);
  }

  void _handleGenericError(BuildContext context, dynamic error) {
    debugPrint('❌ Error crítico: $error');
    submitErrorSignal.value = 'Error interno: ${error.toString()}';

    showCustomSnackBar(
      context: context,
      title: 'Error interno en la aplicación',
      titleColor: Colors.white,
      icon: Icons.error_outline,
      backgroundColor: Colors.red,
      isPersistent: true,
      showAcceptButton: true,
    );
  }

  void _storeTransaction({
    required BuildContext context,
    required String paymentMethod,
    required String status,
    required String sequenceNumber,
    required double total,
    required String price,
  }) {
    final trip = tripsSelectSignal.value;
    if (trip == null) {
      debugPrint('Error: Trip es null');
      return;
    }

    final ticket = Ticket(
      id: DateTime.now().millisecondsSinceEpoch,
      branchId: currentUserBranchLG.value!.id,
      tripId: trip.id!,
      method: paymentMethod,
      quantity: quantitySignal.value + quantityMenoresSignal.value,
      price: double.parse(price),
      seats: selectedSeatNumbersSN.value,
      date: DateFormat('yyyy-MM-dd').format(trip.date!),
      adults: quantitySignal.value,
      minors: quantityMenoresSignal.value,
      total: total,
      status: status == 'completed' ? 1 : 0,
      transactionStatus: status,
      sequenceNumber: sequenceNumber,
      transactionCashback: 0.0,
    );

    dbHelper.insertTicket(ticket).then((_) {
      debugPrint('Ticket almacenado exitosamente');
    }).catchError((error) {
      debugPrint('Error guardando ticket: $error');
    });
  }

  void _resetTransactionState() {
    quantitySignal.value = 0;
    quantityMenoresSignal.value = 0;
    selectedSeatNumbersSN.value = [];
    tripsSelectSignal.value = null;
    isProductSubmittingSignal.value = false;
    productSubmittedSuccessSignal.value = false;
    submitErrorSignal.value = '';
  }

  final paymentService = HaulmerPayment(apiKey: '', deviceId: '');

  Future<Map<String, dynamic>> handlePayment(
      amount,
      cashback,
      dteType,
      customFields,
      exemptAmount,
      externalReferenceId,
      flagAccountPayProvider,
      idProviderAccount,
      netAmount,
      sourceName,
      sourceVersion,
      taxIdnValidation,
      installmentsQuantity,
      method,
      printVoucherOnApp,
      tip) async {
    try {
      final result = await paymentService.sendPaymentIntentClick(
          amount,
          cashback,
          dteType,
          customFields,
          exemptAmount,
          externalReferenceId,
          flagAccountPayProvider,
          idProviderAccount,
          netAmount,
          sourceName,
          sourceVersion,
          taxIdnValidation,
          installmentsQuantity,
          method,
          printVoucherOnApp,
          tip);
      Map<String, dynamic> jsonResponse = Map<String, dynamic>.from(result);
      return jsonResponse;

      // if (result["success"] == true) {
      // storeTrip(branch_id,trip_id,'method','status',quantity,widget.price,total,seats,date,adults,minors);
      // int branch_id = 1;
      // int trip_id = tripsSelectSignal.value!.id!;
      // int quantity = quantityMenoresSignal.value + quantitySignal.value;
      // double total = ((double.parse(widget.price) / 2) *
      //         quantityMenoresSignal.watch(context)) +
      //     ((double.parse(widget.price)) * quantitySignal.watch(context));
      // List<int> seats = selectedSeatNumbersSN.value;
      // DateTime date = tripsSelectSignal.value!.date!;
      // int adults = quantitySignal.value;
      // int minors = quantityMenoresSignal.value;
      // storeTrip(branch_id, trip_id, 'method', 'status', quantity, widget.price,
      //     total, seats, date, adults, minors);
      // showCustomSnackBar(
      //   context: context,
      //   title: 'Compra de pasaje realizada con éxito', // Obligatorio
      //   titleColor: Colors.white, // Opcional
      //   icon: Icons.check_circle, // Opcional
      //   backgroundColor: Colors.green, // Opcional
      //   duration: Duration(seconds: 5), // Opcional
      // );

      // GoRouter.of(context).go('/DashboardPage');
      // }
    } catch (e) {
      return {
        "error": "La respuesta del pago entro en el catch-handlePayment:$e"
      };
    } finally {
      //Navigator.pop(context);
    }
  }
}
