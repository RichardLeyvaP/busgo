import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
import 'package:BusGo/models/trips/trips_model.dart';
import 'package:BusGo/repository/trips_repository.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart'; // Ajustar según tu estructura

final tripsRepository = TripsRepository(authService: ApiService()); // Crear repositorio si no lo tienes

Future<void> fetchTrips(int branchId) async {
  isLoadingTripsSignal.value = true; // Indicamos que está cargando
  tripsErrorSignal.value = null; // Limpiamos posibles errores previos

  try {
    final result = await tripsRepository.getTripssRepository(branchId); // Llamada al backend

    if (result is Trips) {
      tripsSignal.value = result.trips; // Actualizamos las señales con los datos
    } else if (result is String) {
      tripsErrorSignal.value = result; // Guardamos el mensaje de error si aplica
    }
  } catch (e) {
    tripsErrorSignal.value = "Error: ${e.toString()}"; // Error inesperado
  } finally {
    isLoadingTripsSignal.value = false; // Finalizamos el estado de carga
  }
}
Future<void> storeTrip(branch_id,trip_id,method,status,quantity,price,total,seats,date,adults,minors) async {
  isLoadingTripsSignal.value = true; // Indicamos que está cargando
  tripsErrorSignal.value = null; // Limpiamos posibles errores previos

  try {
    final result = await tripsRepository.storeTripRepository(branch_id,trip_id,method,status,quantity,price,total,seats,date,adults,minors); // Llamada al backend

     if (result is String) {
      tripsErrorSignal.value = result; // Guardamos el mensaje de error si aplica
    }
  } catch (e) {
    tripsErrorSignal.value = "Error: ${e.toString()}"; // Error inesperado
  } finally {
    isLoadingTripsSignal.value = false; // Finalizamos el estado de carga
  }
}
//storeTripRepository(branch_id,trip_id,method,status,quantity,price,total,seats,date,adults,minors)



void dataSelectedRoute(int idTrip) {
  // Verifica si tripsSignal no es null y contiene datos
  if (tripsSignal.value != null) {
    // Filtra los viajes que coinciden con el idTrip
    final filteredTrips = tripsSignal.value!.where((trip) => trip.id == idTrip).toList();
    // Actualiza tripsSelectSignal con los viajes filtrados
    tripsSelectSignal.value = filteredTrips.isNotEmpty ? filteredTrips.first : null;
  } else {
    // Si no hay datos en tripsSignal, tripsSelectSignal también debe ser null
    tripsSelectSignal.value = null;
  }
  print('ruta seleccionada:${tripsSelectSignal.value}');
}
