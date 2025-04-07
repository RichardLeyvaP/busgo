import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/models/ticket/tickets_model.dart';
import 'package:BusGo/models/trips/trips_model.dart';
import 'package:BusGo/repository/trips_repository.dart';
import 'package:BusGo/util/HaulmerPayment/haulmerPayment%20_http.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart'; // Ajustar según tu estructura

final tripsRepository = TripsRepository(
    authService: ApiService()); // Crear repositorio si no lo tienes

Future<void> reprintTickets(int id) async {
  try {
    await tripsRepository.reprintTicketsRepository(
        id); // Llamada al backend solo para saber que se reimprimio
  } catch (e) {
    ticketsErrorSignal.value = "Error: ${e.toString()}"; // Error inesperado
  } finally {
    isLoadingTicketsSignal.value = false; // Finalizamos el estado de carga
  }
}

Future<void> getTickets(int branchId, String date) async {
  isLoadingTicketsSignal.value = true; // Indicamos que está cargando
  ticketsErrorSignal.value = null; // Limpiamos posibles errores previos
  ticketsSignal.value = null;

  try {
    final result = await tripsRepository.getTicketRepository(
        branchId, date); // Llamada al backend

    if (result is Tickets) {
      ticketsSignal.value =
          result.tickets; // Actualizamos las señales con los datos
    } else if (result is String) {
      ticketsErrorSignal.value =
          result; // Guardamos el mensaje de error si aplica
    }
  } catch (e) {
    ticketsErrorSignal.value = "Error: ${e.toString()}"; // Error inesperado
  } finally {
    isLoadingTicketsSignal.value = false; // Finalizamos el estado de carga
  }
}

Future<void> fetchTrips(int branchId) async {
  isLoadingTripsSignal.value = true; // Indicamos que está cargando
  tripsErrorSignal.value = null; // Limpiamos posibles errores previos

  try {
    final result = await tripsRepository
        .getTripssRepository(branchId); // Llamada al backend

    if (result is Trips) {
      tripsSignal.value =
          result.trips; // Actualizamos las señales con los datos
    } else if (result is String) {
      tripsErrorSignal.value =
          result; // Guardamos el mensaje de error si aplica
    }
  } catch (e) {
    tripsErrorSignal.value = "Error: ${e.toString()}"; // Error inesperado
  } finally {
    isLoadingTripsSignal.value = false; // Finalizamos el estado de carga
  }
}

Future<bool> storeTripLocal(id, branch_id, trip_id, method, quantity, price,
    total, seats, date, adults, minors) async {
  isLoadingTripsSignal.value = true; // Indicamos que está cargando
  tripsErrorSignal.value = null; // Limpiamos posibles errores previos

  try {
    final result = await tripsRepository.storeTripRepositoryLocal(
        id,
        branch_id,
        trip_id,
        method,
        quantity,
        price,
        total,
        seats,
        date,
        adults,
        minors); // Llamada al backend

    if (result is int) {
      if (result == 200 || result == 201) {
        return true;
      } else {
        return false;
      }
    } else if (result is String) {
      tripsErrorSignal.value =
          result; // Guardamos el mensaje de error si aplica
    }
    return true;
    //aqui rectificar el estatust qsi es 200 que siga con el proceso de pago y devuelva true
    //sin no que devuelva false
  } catch (e) {
    tripsErrorSignal.value = "Error: ${e.toString()}"; // Error inesperado
    return false;
  } finally {
    isLoadingTripsSignal.value = false; // Finalizamos el estado de carga
  }
}

Future<bool> storeTrip(
    branch_id,
    trip_id,
    method,
    status,
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
    transactionCashback) async {
  isLoadingTripsSignal.value = true; // Indicamos que está cargando
  tripsErrorSignal.value = null; // Limpiamos posibles errores previos

  try {
    final result = await tripsRepository.storeTripRepository(
        branch_id,
        trip_id,
        method,
        status,
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
        transactionCashback); // Llamada al backend

    if (result is String) {
      tripsErrorSignal.value =
          result; // Guardamos el mensaje de error si aplica
    }
    return true;
  } catch (e) {
    tripsErrorSignal.value = "Error: ${e.toString()}"; // Error inesperado
    return false;
  } finally {
    isLoadingTripsSignal.value = false; // Finalizamos el estado de carga
  }
}
//storeTripRepository(branch_id,trip_id,method,status,quantity,price,total,seats,date,adults,minors)

void dataSelectedRoute(int idTrip) {
  // Verifica si tripsSignal no es null y contiene datos
  if (tripsSignal.value != null) {
    // Filtra los viajes que coinciden con el idTrip
    final filteredTrips =
        tripsSignal.value!.where((trip) => trip.id == idTrip).toList();
    // Actualiza tripsSelectSignal con los viajes filtrados
    tripsSelectSignal.value =
        filteredTrips.isNotEmpty ? filteredTrips.first : null;
  } else {
    // Si no hay datos en tripsSignal, tripsSelectSignal también debe ser null
    tripsSelectSignal.value = null;
  }
  print('ruta seleccionada:${tripsSelectSignal.value}');
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
