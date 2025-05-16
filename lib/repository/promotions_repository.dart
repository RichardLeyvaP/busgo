import 'package:BusGo/models/promotions/promotions_model.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart';
import 'package:BusGo/env.dart';

/// Excepciones específicas para distinguir tipos de fallo.
class PromotionFetchException implements Exception {
  final String message;
  PromotionFetchException(this.message);

  @override
  String toString() => 'PromotionFetchException: $message';
}

class PromotionSaveException implements Exception {
  final String message;
  PromotionSaveException(this.message);

  @override
  String toString() => 'PromotionSaveException: $message';
}

class PromotionsRepository {
  final ApiService _api;

  PromotionsRepository(this._api);

  Future<List<Promotion>> getAll() async {
    final url = '${Env.apiEndpoint}/get-promotion';
    try {
      final resp = await _api.get(url);
      print('Respuesta cruda del API: $resp');

      // Paso 1: Extraer el "body" de la respuesta
      final responseBody = resp['body'] as Map<String, dynamic>; // <-- Aquí está el cambio clave

      // Paso 2: Extraer "promotions" del body
      final List<dynamic> promosJson = responseBody['promotions'] as List<dynamic>;

      return promosJson
          .map((json) => Promotion.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw PromotionFetchException('Error: $e');
    }
  }

  Future<Promotion> create(Promotion promo) async {
    final url = '${Env.apiEndpoint}/get-promotion';
    try {
      final resp = await _api.post(url, body: promo.toJson());
      final body = _unwrapBody<Map<String, dynamic>>(resp);
      return Promotion.fromJson(body);
    } catch (e) {
      throw PromotionSaveException(e.toString());
    }
  }

  Future<Promotion> update(Promotion promo) async {
    if (promo.id == null) {
      throw PromotionSaveException('Promotion id is required for update');
    }
    final url = '${Env.apiEndpoint}/get-promotion/${promo.id}';
    try {
      final resp = await _api.put(url, body: promo.toJson());
      final body = _unwrapBody<Map<String, dynamic>>(resp);
      return Promotion.fromJson(body);
    } catch (e) {
      throw PromotionSaveException(e.toString());
    }
  }

  T _unwrapBody<T>(dynamic response) {
    // Si el API devuelve directamente la lista (poco probable en este caso)
    if (response is T) return response;

    // Si el API devuelve un objeto con la lista en "promotions"
    if (response is Map<String, dynamic>) {
      if (response.containsKey('promotions')) {
        final promotions = response['promotions'];
        if (promotions is T) return promotions;
        throw PromotionFetchException(
          'La clave "promotions" no es del tipo esperado: ${promotions.runtimeType}',
        );
      }
      throw PromotionFetchException('El API no incluyó la clave "promotions"');
    }

    throw PromotionFetchException(
      'Respuesta del API en formato inválido: ${response.runtimeType}',
    );
  }
}
