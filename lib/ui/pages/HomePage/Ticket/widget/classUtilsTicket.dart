import 'package:BusGo/data/services/local_database_service.dart';
import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/models/SeatModel.dart';
import 'package:BusGo/models/ticket/ticket_dabase_local/ticket_dabase_local_model.dart';
import 'package:BusGo/ui/component/internetConnectionModal_component.dart';
import 'package:BusGo/ui/component/showCustomSnackBar_component.dart';
import 'package:BusGo/ui/pages/PrinterPage/widget/classUtilsPrinterTicketLocal.dart';
import 'package:BusGo/util/util_class_sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';
import 'package:intl/intl.dart';
import 'package:BusGo/repository/trips_repository.dart';
import '../../../../../domain/signals/tickets_signals/tickets_service.dart';
import '../../../../../models/promotions/promotions_model.dart';
import '../../../../../models/trips/trips_model.dart';
import '../../../../../util/HaulmerPayment/haulmerPayment _http.dart';
import '../TicketPage.dart';

List<Seat> generateSeatsFromTrip(Trip trip) {
  const totalLayoutSeats = 29;
  final capacidad = trip.seats ?? 0;
  final reserved = trip.reservedSeats ?? [];

  Seat make(int n) {
    final out = n > capacidad;
    return Seat(
      number: n,
      isOccupied: reserved.contains(n) || out,
    );
  }

  List<Seat> seats = [];

  // 6 filas de 4 asientos + pasillo
  for (int i = 1; i <= 24; i += 4) {
    seats.add(make(i));
    seats.add(make(i + 1));
    seats.add(Seat(number: -1, isOccupied: false)); // pasillo
    seats.add(make(i + 2));
    seats.add(make(i + 3));
  }

  // Última fila de 5 asientos (sin pasillo)
  for (int i = 25; i <= totalLayoutSeats; i++) {
    seats.add(make(i));
  }

  return seats;
}

Future<void> verifyPurchaseTicketClass(
  BuildContext context,
  String price, {
  required String paymentMethod,
}) async {
  if (selectedSeatNumbersSN.value.isEmpty) {
    showCustomSnackBar(
      context: context,
      title: 'No hay asientos seleccionados',
      backgroundColor: Colors.red,
    );
    return;
  }

  // 1. Calcula total
  final double priceDouble = double.parse(price);
  final int adults = quantitySignal.value;
  final int minors = quantityMenoresSignal.value;
  final double total = (priceDouble * adults) + ((priceDouble / 2) * minors);

  // 2. método a código para TUU
  // int paymentMethodCode = 0; // Efectivo
  // String paymentMethodStr = 'Efectivo';
  // if (paymentMethod == 'Crédito') {
  //   paymentMethodCode = 1;
  //   paymentMethodStr = 'Crédito';
  // } else if (paymentMethod == 'Débito') {
  //   paymentMethodCode = 2;
  //   paymentMethodStr = 'Débito';
  // }

  int paymentMethodCode = 2; // Forzar Débito
  String paymentMethodStr = 'Débito';

  // 3. Llama a TUU
  final jsonResponse = await handlePayment(
    total,
    -1, // cashback
    48, // dteType
    [], // customFields
    0, // exemptAmount
    null, // externalReferenceId
    false, // flagAccountPayProvider
    null, // idProviderAccount
    0, // netAmount
    "", // sourceName
    "", // sourceVersion
    "", // taxIdnValidation
    -1, // installmentsQuantity
    paymentMethodCode,
    false, // printVoucherOnApp
    -1, // tip
  );

  // 4. Maneja la respuesta
  handleResponse(
    jsonResponse,
    context,
    total,
    price,
    paymentMethod: paymentMethodStr,
  );
}

final DatabaseHelper dbHelper =
    DatabaseHelper(); // Instancia de la base de datos
SharedPreferencesStorage sharedPreferencesStorage =
    SharedPreferencesStorage(); // Instancia de la base de datos

Future<void> modalResponseConecction(
    BuildContext contextT, {
      Map<String, Promotion?> selectedPromotions = const {},
    }) async {
  // 1) Base price
  final double basePrice =
  double.parse(tripsSelectSignal.value!.price ?? '0.0');

  // 2) Helper para precio con descuento
  double _priceWithDiscount(String key) {
    final promo = selectedPromotions[key];
    if (promo != null) {
      return basePrice * (1 - promo.percentage / 100);
    }
    return basePrice;
  }

  // 3) Cantidades
  final int qtyNormal = quantitySignal.value;
  final int qtyMenores = quantityMenoresSignal.value;
  final int qtyAdultos = quantityAdultsSignal.value;

  // 4) Total final consistente con PaymentCard
  final double total =
      _priceWithDiscount('Pasaje Normal') * qtyNormal +
          _priceWithDiscount('Menores de Edad') * qtyMenores +
          _priceWithDiscount('Adultos Mayores') * qtyAdultos;

  // 5) Llamada al modal, pasándole ese total
  InternetConnectionModal.show(
    contextT,
    total: total,
    onPayWithCash: () async {
      // YA no vuelvas a recalcular ‘total’ aquí: usa el de arriba.
      Ticket newTicket = Ticket(
        id: DateTime.now().millisecondsSinceEpoch,
        branchId: currentUserBranchLG.value!.id,
        tripId: tripsSelectSignal.value!.id!,
        method: 'Efectivo',
        quantity: qtyNormal + qtyMenores + qtyAdultos,
        price: basePrice,
        seats: selectedSeatNumbersSN.value,
        date: DateFormat('yyyy-MM-dd')
            .format(tripsSelectSignal.value!.date!),
        adults: qtyNormal,
        minors: qtyMenores,
        total: total,
        status: 1,
        transactionStatus: 'pending',
        sequenceNumber: 'abc123',
        transactionTip: 10.0,
        transactionCashback: 5.0,
      );

      final resultTicket = await dbHelper.insertTicket(newTicket);
      if (resultTicket != null) {
        sharedPreferencesStorage.incrementCounter();
        showCustomSnackBar(
          context: contextT,
          title: 'Compra de Ticket guardada correctamente db-Local',
          backgroundColor: Colors.green,
        );
        UtilsPrinterTicketLocal utilsPrinter =
        UtilsPrinterTicketLocal();
        String scheduleActual =
        DateFormat('HH:mm').format(DateTime.now());
        await utilsPrinter.printTicketPasajeLocal(
          newTicket,
          scheduleActual,
          tripsSelectSignal.value!.origin.toString(),
          tripsSelectSignal.value!.destination.toString(),
        );
      } else {
        showCustomSnackBar(
          context: contextT,
          title: 'Error al guardar el Ticket',
          backgroundColor: Colors.red,
        );
      }
    },
    onCancel: () {
      // Lógica cuando se cancela
    },
  );
}


void handleResponse(
  Map<String, dynamic> jsonResponse,
  BuildContext context,
  double total,
  String price, {
  required String paymentMethod,
}) async {
  // Detecta errores
  if (jsonResponse.containsKey('errorCode') ||
      jsonResponse.containsKey('error')) {
    _handleErrorResponse(jsonResponse, context);
    return;
  }

  // Pago exitoso o fallido
  if (jsonResponse['transactionStatus'] == true) {
    final sequenceNumber = jsonResponse['sequenceNumber']?.toString() ?? 'N/A';
    final double priceDouble = double.parse(price);
    final trip = tripsSelectSignal.value!;

    // 1. Enviar al backend
    final sent = await _sendTicketToServer(
      trip: trip,
      paymentMethod: paymentMethod,
      transactionStatus: 'completed',
      sequenceNumber: sequenceNumber,
      total: total,
      price: priceDouble,
    );
    if (!sent) {
      showCustomSnackBar(
        context: context,
        title: 'Error al enviar ticket al servidor',
        backgroundColor: Colors.red,
      );
      return;
    }

    // 2. Guardar en BD local e imprimir
    final ticket = Ticket(
      branchId: currentUserBranchLG.value!.id,
      tripId: trip.id!,
      method: paymentMethod,
      status: 1,
      quantity: quantitySignal.value + quantityMenoresSignal.value,
      price: priceDouble,
      total: total,
      seats: selectedSeatNumbersSN.value,
      date: DateFormat('yyyy-MM-dd').format(trip.date!),
      adults: quantitySignal.value,
      minors: quantityMenoresSignal.value,
      sequenceNumber: sequenceNumber,
      transactionStatus: 'completed',
    );

    final int? localId = await dbHelper.insertTicket(ticket);
    if (localId == null) {
      showCustomSnackBar(
        context: context,
        title: 'Error guardando ticket',
        backgroundColor: Colors.red,
      );
      return;
    }

    // Recrea el ticket ahora con el ID real para impresión
    final ticketForPrint = ticket.copyWith(id: localId);

    // Imprime
    final scheduleActual = DateFormat('HH:mm').format(DateTime.now());
    await utilsPrinterTicketLocal.printTicketPasajeLocal(
      ticketForPrint,
      scheduleActual,
      trip.origin.toString(),
      trip.destination.toString(),
    );

    // Feedback y navegación
    showCustomSnackBar(
      context: context,
      title: 'Pago exitoso • Folio $sequenceNumber',
      backgroundColor: Colors.green,
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => GoRouter.of(context).go('/SalesPage'),
    );
    return;
  }

  // Respuesta inesperada
  _handleUnknownResponse(jsonResponse, context);
}

void _showSuccessFeedback(BuildContext context, String transactionId) {
  showCustomSnackBar(
    context: context,
    title: 'Pago exitoso • N° $transactionId',
    backgroundColor: Colors.green,
  );
}

void _handleErrorResponse(Map<String, dynamic> response, BuildContext context) {
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

Future<bool> _sendTicketToServer({
  required Trip trip,
  required String paymentMethod,
  required String transactionStatus,
  required String sequenceNumber,
  required double total,
  required double price,
}) async {
  final branchId = currentUserBranchLG.value!.id;
  final tripId = trip.id!;
  final quantity = quantitySignal.value + quantityMenoresSignal.value;
  final seats = selectedSeatNumbersSN.value;
  final date = DateFormat('yyyy-MM-dd').format(trip.date!);
  final adults = quantitySignal.value;
  final minors = quantityMenoresSignal.value;

  try {
    await tripsRepository.storeTripRepository(
      branchId,
      tripId,
      paymentMethod,
      transactionStatus == 'completed' ? 1 : 0,
      quantity,
      price,
      total,
      seats,
      date,
      adults,
      minors,
      transactionStatus,
      sequenceNumber,
      null,
      0.0,
      0.0,
    );
    return true;
  } catch (e) {
    debugPrint('Error enviando ticket al servidor: $e');
    return false;
  }
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
  } catch (e) {
    return {
      "error": "La respuesta del pago entro en el catch-handlePayment:$e"
    };
  } finally {
    //Navigator.pop(context);
  }
}
