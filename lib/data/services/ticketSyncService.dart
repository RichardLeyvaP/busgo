import 'dart:async';
import 'package:BusGo/data/services/local_database_service.dart';
import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/tickets_signals/tickets_service.dart';
import 'package:BusGo/util/util_class_sharedPreferences.dart';

class TicketSyncService {
  final DatabaseHelper dbHelper;

  TicketSyncService({required this.dbHelper});
SharedPreferencesStorage sharedPreferencesStorage = SharedPreferencesStorage(); // Instancia de la base de datos
  Future<void> syncPendingTickets() async {
    int count = await dbHelper.getTicketCount();
    //actualizo la variable de sharedpreferences por si estubiera desactualizada
    await sharedPreferencesStorage.updateCounter(count);
    final tick = await dbHelper.getTickets();

    if (count > 0) {
      print('***** Hay $count tickets pendientes en la base de datos local.');

      for (var ticket in tick) {
        int branchId = currentUserBranchLG.value!.id;

        try {
          // Enviar el ticket a la API y recibir una respuesta
          final response = await storeTripLocal(
            ticket.id,
            branchId,
            3,
            "Efectivo",
            ticket.quantity,
            ticket.price,
            ticket.total,
            ticket.seats,
            ticket.date,
            ticket.adults,
            ticket.minors,
          );

          // Verificar si la respuesta indica éxito antes de eliminar el ticket
          if (response == true ) {
            await dbHelper.deleteTicket(ticket.id!);
          await sharedPreferencesStorage.decrementCounter();
            print('✓ Ticket ${ticket.id} sincronizado y eliminado de la DB local.');
          } else {
            print('✗ Error: La API no confirmó el éxito del ticket ${ticket.id}. No se eliminará de la DB local.');
          }
        } catch (e) {
          print('✗ Error al sincronizar el ticket ${ticket.id}: $e');
        }

        // Esperar 3 segundos antes de la siguiente iteración
        await Future.delayed(Duration(seconds: 3));
      }
    } else {
      print('***** No hay tickets pendientes en la base de datos local.');
    }
  }
}
