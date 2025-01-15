
import 'package:BusGo/models/trips/trips_model.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart';
import 'package:BusGo/env.dart';

class TripsRepository {
  final ApiService authService;

  TripsRepository({required this.authService});

 Future<dynamic> getTripssRepository(int branchId) async {
    final endpoint = '${Env.apiEndpoint}/get-trip-date';
    final body = {
      'branch_id': branchId ,
      };

    try {
      // Llama al servicio y obtiene la respuesta procesada
      final response = await authService.post(endpoint, body: body);

      // Verificamos si response es un JSON válido
      if (response is Map<String, dynamic>) {
        // Deserializamos la respuesta a nuestro modelo TaskResponse
if (response['body'] is String) {//es que no hay viajes
return null;
   }
        final taskResponse = Trips.fromJson(response['body']);
        // Retornamos el modelo deserializado
        print('dando click en la imagen-3:$taskResponse');
        return taskResponse;
      } else if (response is String) {
        print('dando click en la imagen-4:$response');
        return response;
      } else {
        print('dando click en la imagen-5:$response');
        throw Exception('Respuesta inesperada del servidor.Revise su conexión');
      }
    } catch (e) {
      print('dando click en la imagen-4:$e');
      // Manejo de errores
      throw Exception('getTasks(date): $e');
    }
  }
  
 Future<dynamic> storeTripRepository(branch_id,trip_id,method,status,quantity,price,total,seats,date,adults,minors) async {
    final endpoint = '${Env.apiEndpoint}/trip';
    final body = {
  'branch_id': branch_id,
  'trip_id': trip_id,
  'method': method,
  'status': status,
  'quantity': quantity,
  'price': price,
  'total': total,
  'seats': seats,
  'date': '2024-10-03',
  'adults': adults,
  'minors': minors,
};
print('mostrar que es lo que va por el body:$body');


    try {
      // Llama al servicio y obtiene la respuesta procesada
      final response = await authService.post(endpoint, body: body);

      // Verificamos si response es un JSON válido
      if (response is Map<String, dynamic>) {
        // Deserializamos la respuesta a nuestro modelo TaskResponse
if (response['body'] is String) {//es que no hay viajes
return response['body'];
   }      
      } else if (response is String) {
        print('dando click en la imagen-4:$response');
        return response;
      } else {
        print('dando click en la imagen-5:$response');
        throw Exception('Respuesta inesperada del servidor.Revise su conexión');
      }
    } catch (e) {
      print('dando click en la imagen-4:$e');
      // Manejo de errores
      throw Exception('getTasks(date): $e');
    }
  }









  }//fin TripsRepository
