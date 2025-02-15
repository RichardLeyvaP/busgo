
import 'package:BusGo/models/trips/trips_model.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart';
import 'package:BusGo/env.dart';

class TripsRepository {
  final ApiService authService;

  TripsRepository({required this.authService});

 Future<dynamic> getTripssRepository(int branchId) async {
  final endpoint = '${Env.apiEndpoint}/get-trip-date';
  final body = {
    'branch_id': branchId,
  };

  try {
    // Llama al servicio y obtiene la respuesta procesada
    final response = await authService.post(endpoint, body: body);

    // Verificamos si la respuesta es un Map y si contiene el cuerpo
    if (response is Map<String, dynamic>) {
      // Verificamos si el campo 'body' está presente y es del tipo esperado
      if (response.containsKey('body')) {
        final body = response['body'];

        // Verificamos si 'body' es un Map
        if (body is Map<String, dynamic>) {
          // Si 'body' es un Map, deserializamos la respuesta a nuestro modelo Trips
          final tripsResponse = Trips.fromJson(body); // Aquí usamos Trips.fromJson en lugar de tripsFromJson
          print('Datos de los viajes: $tripsResponse');
          return tripsResponse;
        } else if (body is String) {
          // Si es una String, significa que no hay viajes, retornamos null
          print('No hay viajes disponibles.');
          return null;
        } else {
          throw Exception('Formato inesperado en el campo "body".');
        }
      } else {
        throw Exception('Respuesta sin el campo "body".');
      }
    } else if (response is String) {
      print('Respuesta como String: $response');
      return response;
    } else {
      throw Exception('Respuesta inesperada del servidor. Revise su conexión.');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('getTripssRepository: $e');
  }
}

 Future<dynamic> storeTripRepository(branch_id,trip_id,method,status,quantity,price,total,seats,date,adults,minors) async {
    final endpoint = '${Env.apiEndpoint}/ticket';
    final body = {
  'branch_id': branch_id,
  'trip_id': trip_id,
   'method': 'Efectivo',
  // 'method': method,
  'status': 1,
  // 'status': status,
  'quantity': quantity,
  'price': price,
  'total': total,
  'seats': seats,
  'date': date.toString(),
  'adults': adults,
  'minors': minors,
  //agregar datos de pago
  // 'amount': amount,
  //       'description': description,
  //       'transactionId': transactionId,
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
