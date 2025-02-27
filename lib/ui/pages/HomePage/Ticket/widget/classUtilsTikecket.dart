import 'package:BusGo/domain/signals/tickets/tickets_service.dart';
import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
import 'package:BusGo/models/SeatModel.dart';
import 'package:BusGo/ui/component/showCustomSnackBar.dart';
import 'package:BusGo/ui/component/showJsonDialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      handleResponse(jsonResponse,context,total,price);
      //SI TD ESTA BIEN 
   
    }
  }

  void handleResponse(Map<String, dynamic> jsonResponse,BuildContext contextT,double total,price) {
  if (jsonResponse.containsKey("errorCode")) {//DIO ERRORRRRRRRRRRRRRRR
    // Manejo de error
    int errorCode = jsonResponse["errorCode"];
    String errorMessage = jsonResponse["errorMessage"] ?? "Error desconocido";
    int errorCodeOnApp = jsonResponse["errorCodeOnApp"] ?? 0;
    String errorMessageOnApp = jsonResponse["errorMessageOnApp"] ?? "Error en la app";
 showCustomSnackBar(
        context: contextT,
        title: 'Error Code: $errorCode ,error menssage:$errorMessage', // Obligatorio
        titleColor: Colors.white, // Opcional
        icon: Icons.check_circle, // Opcional
        backgroundColor: Colors.red, // Opcional
        isPersistent: true,
        showAcceptButton: true
      );
    
    // Aquí podrías mostrar un mensaje en la UI o manejar el error como prefieras
    return;
  }

  if (jsonResponse.containsKey("transactionStatus")) {// SE EFECTUO CORRECTAMENTE EL PAGOOOOOOOOOOOO
    // Respuesta exitosa
    bool transactionStatus = jsonResponse["transactionStatus"] ?? false;
    String sequenceNumber = jsonResponse["sequenceNumber"] ?? "";
    bool printerVoucherCommerce = jsonResponse["printerVoucherCommerce"] ?? false;
    dynamic transactionTip = jsonResponse["transactionTip"];
    Map<String, dynamic>? extraData = jsonResponse["extraData"];
    

 showCustomSnackBar(
        context: contextT,
        title: "transactionStatus:$transactionStatus , sequenceNumber: $sequenceNumber , printerVoucherCommerce: $printerVoucherCommerce , transactionTip: $transactionTip , extraData: $extraData ", // Obligatorio
        titleColor: Colors.white, // Opcional
        icon: Icons.check_circle, // Opcional
        backgroundColor: Colors.red, // Opcional
        isPersistent: true,
        showAcceptButton: true
      );
      

    if (extraData != null) {
      print("📦 Datos adicionales: $extraData");
    }

        
    //  storeTrip(branch_id,trip_id,'method','status',quantity,widget.price,total,seats,date,adults,minors);
      int branch_id = 1;
      int trip_id = tripsSelectSignal.value!.id!;
      int quantity = quantityMenoresSignal.value + quantitySignal.value;
      List<int> seats = selectedSeatNumbersSN.value;
      DateTime date = tripsSelectSignal.value!.date!;
      int adults = quantitySignal.value;
      int minors = quantityMenoresSignal.value;

      //AQUI MANDA PARA LA DB A GUARDAR EL TICKET
     storeTrip(branch_id,trip_id,'method','status',quantity,price,total,seats,date,adults,minors,transactionStatus,
        sequenceNumber,
        extraData,
        transactionTip,
        'transactionCashback')  ; 

     // GoRouter.of(contextT).go('/DashboardPage');
    

    // Aquí podrías continuar con el flujo de la aplicación
  } else {
    print("⚠️ Respuesta desconocida: $jsonResponse");
     showCustomSnackBar(
        context: contextT,
        title: "⚠️ Respuesta desconocida: $jsonResponse", // Obligatorio
        titleColor: Colors.white, // Opcional
        icon: Icons.check_circle, // Opcional
        backgroundColor: Colors.red, // Opcional
        isPersistent: true,
        showAcceptButton: true
      );
  }
}
}