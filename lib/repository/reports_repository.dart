
import 'package:BusGo/models/reports/report1/report1_model.dart';
import 'package:BusGo/models/reports/report2/report2_model.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart';
import 'package:BusGo/env.dart';

class ReportsRepository {
  final ApiService authService;

  ReportsRepository({required this.authService});

 Future<dynamic> getReports1Repository( id, type,date,endDate) async {
  final endpoint = '${Env.apiEndpoint}/ticket-sold-date';
  final body = {
    'id': id,
    'type': type,
    'date': date,
    'endDate' : endDate,
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
          final tripsResponse = Report1.fromJson(body); // Aquí usamos Trips.fromJson en lugar de tripsFromJson
          print('Datos de los Report1: $tripsResponse');
          return tripsResponse;
        } else if (body is String) {
          // Si es una String, significa que no hay viajes, retornamos null
          print('No hay Report1 disponibles.');
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
    throw Exception('getReports1Repository: $e');
  }
}



 Future<dynamic> getReports2Repository( id, type,date,endDate) async {
  final endpoint = '${Env.apiEndpoint}/trips-tickets-date';
  final body = {
    'id': id,
    'type': type,
    'date': date,
    'endDate' : endDate,
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
          final tripsResponse = Report2.fromJson(body); // Aquí usamos Trips.fromJson en lugar de tripsFromJson
          print('Datos de los Report1: $tripsResponse');
          return tripsResponse;
        } else if (body is String) {
          // Si es una String, significa que no hay viajes, retornamos null
          print('No hay Report1 disponibles.');
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
    throw Exception('getReports2Repository: $e');
  }
}


 Future<dynamic> getReports3Repository( id, type,date,endDate) async {
  final endpoint = '${Env.apiEndpoint}/ticket-sold-date';
  final body = {
    'id': id,
    'type': type,
    'date': date,
    'endDate' : endDate,
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
          final tripsResponse = Report1.fromJson(body); // Aquí usamos Trips.fromJson en lugar de tripsFromJson
          print('Datos de los Report1: $tripsResponse');
          return tripsResponse;
        } else if (body is String) {
          // Si es una String, significa que no hay viajes, retornamos null
          print('No hay Report1 disponibles.');
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
    throw Exception('getReports3Repository: $e');
  }
}



  }//fin ReportsRepository
