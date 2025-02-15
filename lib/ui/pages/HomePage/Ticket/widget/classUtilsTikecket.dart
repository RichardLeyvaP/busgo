import 'package:BusGo/domain/signals/tickets/tickets_service.dart';
import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
import 'package:BusGo/models/SeatModel.dart';
import 'package:BusGo/ui/component/showCustomSnackBar.dart';
import 'package:BusGo/ui/component/showJsonDialog.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

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


 Future<void> verifyPurchaseTicketClass(BuildContext context,price) async {
    if (selectedSeatNumbersSN.value.length <= 0) //no hay asientos seleccionados
    {
      showCustomSnackBar(
        context: context,
        title: 'No hay asientos seleccionados', // Obligatorio
        backgroundColor: Colors.red
      );
    } else //td bien
    {
      double total = ((double.parse(price) / 2) *
              quantityMenoresSignal.watch(context)) +
          ((double.parse(price)) * quantitySignal.watch(context));
      
     Map<String, dynamic> jsonResponse =   await handlePayment(
      total,
      -1,//cashback,
      48,//dteType,
      [],//customFields,
      0,//exemptAmount,
      null,//externalReferenceId,
      false,//flagAccountPayProvider,
     null,// idProviderAccount,
     0,// netAmount,
     "",// sourceName,
     "",// sourceVersion,
     "",// taxIdnValidation,
      -1,//installmentsQuantity,
      0,//method,
      false,//printVoucherOnApp,
      -1//tip
      );
      showJsonDialog(context, jsonResponse);
    }
  }
}