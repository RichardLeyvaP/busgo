import 'package:BusGo/util/globalCallApi/apiService.dart';
import 'package:BusGo/env.dart';

import '../models/tictet_type/tycket_type_model.dart';

/// Excepciones específicas para los ticket types.
class TicketTypeFetchException implements Exception {
  final String message;
  TicketTypeFetchException(this.message);

  @override
  String toString() => 'TicketTypeFetchException: $message';
}

class TicketTypeSaveException implements Exception {
  final String message;
  TicketTypeSaveException(this.message);

  @override
  String toString() => 'TicketTypeSaveException: $message';
}

class TicketTypesRepository {
  final ApiService _api;

  TicketTypesRepository(this._api);

  Future<List<TicketType>> getAll() async {
    final url = '${Env.apiEndpoint}/get-trip-date';
    try {
      final resp = await _api.get(url);
      print('Respuesta cruda del API: $resp');

      // Paso 1: Extraer el "body" de la respuesta
      final responseBody = resp['body'] as Map<String, dynamic>;

      // Paso 2: Extraer "tickettypes" del body
      final List<dynamic> ticketTypesJson = responseBody['tickettypes'] as List<dynamic>;

      return ticketTypesJson
          .map((json) => TicketType.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw TicketTypeFetchException('Error al obtener los ticket types: $e');
    }
  }

  /// Ejemplo de save (en caso de que necesites agregar un ticket type)
  Future<TicketType> create(TicketType ticket) async {
    final url = '${Env.apiEndpoint}/get-trip-date';
    try {
      final resp = await _api.post(url, body: ticket.toJson());
      final body = _unwrapBody<Map<String, dynamic>>(resp);
      return TicketType.fromJson(body);
    } catch (e) {
      throw TicketTypeSaveException('Error al crear ticket type: $e');
    }
  }

  /// Ejemplo de update
  Future<TicketType> update(TicketType ticket) async {
    if (ticket.id == null) {
      throw TicketTypeSaveException('Ticket type id is required for update');
    }
    final url = '${Env.apiEndpoint}/get-trip-date/${ticket.id}';
    try {
      final resp = await _api.put(url, body: ticket.toJson());
      final body = _unwrapBody<Map<String, dynamic>>(resp);
      return TicketType.fromJson(body);
    } catch (e) {
      throw TicketTypeSaveException('Error al actualizar ticket type: $e');
    }
  }

  /// Desempaquetador para respuestas
  T _unwrapBody<T>(dynamic response) {
    if (response is T) return response;

    if (response is Map<String, dynamic>) {
      if (response.containsKey('tickettypes')) {
        final tickettypes = response['tickettypes'];
        if (tickettypes is T) return tickettypes;
        throw TicketTypeFetchException(
          'La clave "tickettypes" no es del tipo esperado: ${tickettypes.runtimeType}',
        );
      }
      throw TicketTypeFetchException('El API no incluyó la clave "tickettypes"');
    }

    throw TicketTypeFetchException(
      'Respuesta del API en formato inválido: ${response.runtimeType}',
    );
  }
}
