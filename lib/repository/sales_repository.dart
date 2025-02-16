
import 'package:BusGo/models/sales/sales_model.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart';
import 'package:BusGo/env.dart';

class SalesRepository {
  final ApiService authService;

  SalesRepository({required this.authService});

 Future<dynamic> getSalesRepository( branchId, type,month) async {
  final endpoint = '${Env.apiEndpoint}/monthly-sales';
  final body = {
    'branch_id': branchId,
    'type': type,
    'month': month,
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
          final tripsResponse = Sales.fromJson(body); // Aquí usamos Trips.fromJson en lugar de tripsFromJson
          print('Datos de los Sales: $tripsResponse');
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



  }//fin SalesRepository
