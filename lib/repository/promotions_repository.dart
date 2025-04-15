import 'package:BusGo/models/promotions/promotions_model.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart';
import 'package:BusGo/env.dart';

class PromotionsRepository {
  final ApiService authService;

  PromotionsRepository({ required this.authService });

  // Obtiene una lista de promociones desde el servidor
  Future<List<Promotion>> getPromotionsRepository() async {
    final endpoint = '${Env.apiEndpoint}/promotions'; // Ajusta este endpoint según tu API.

    try {
      // Suponemos que se trata de un GET, pero si fuera un POST, adapta la llamada.
      final response = await authService.get(endpoint);

      // Si la respuesta es un Map y contiene la clave 'body'
      if (response is Map<String, dynamic> && response.containsKey('body')) {
        // Esperamos que 'body' sea una lista de objetos en formato JSON.
        final List<dynamic> promotionsJson = response['body'];
        final promotions = promotionsJson
            .map((json) => Promotion.fromJson(json as Map<String, dynamic>))
            .toList();
        return promotions;
      } else {
        throw Exception('Formato de respuesta inesperado.');
      }
    } catch (e) {
      print('Error en getPromotionsRepository: $e');
      throw Exception('getPromotionsRepository: $e');
    }
  }

  // Almacena o actualiza una promoción en el servidor
  Future<dynamic> storePromotionRepository(Promotion promotion) async {
    final endpoint = '${Env.apiEndpoint}/promotion'; // Ajusta según el endpoint real.
    final body = {
      'id': promotion.id,
      'name': promotion.name,
      'percentage': promotion.percentage,
      'description': promotion.description,
    };

    try {
      // Realiza la petición POST (o PUT según lo que requiera tu API)
      final response = await authService.post(endpoint, body: body);

      // Procesa la respuesta de acuerdo a lo que envíe el servidor
      if (response is Map<String, dynamic> && response.containsKey('body')) {
        return response['body'];
      } else if (response is String) {
        return response;
      } else {
        throw Exception('Respuesta inesperada del servidor.');
      }
    } catch (e) {
      print('Error en storePromotionRepository: $e');
      throw Exception('storePromotionRepository: $e');
    }
  }
}
