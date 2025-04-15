import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  // Verifica si hay conexión a Internet de manera más confiable
  Future<bool> checkInternetConnection() async {
    // Verifica la conectividad
    var connectivityResult = await Connectivity().checkConnectivity();
    // Depuración: Mostrar el tipo de conectividad
    print('TIENE CONEXION-Connectivity result: ${connectivityResult.first}');

    // Si estamos conectados a Wi-Fi o móvil, comprobamos el acceso real a Internet
    if (connectivityResult.first == ConnectivityResult.wifi || connectivityResult.first == ConnectivityResult.mobile) {
      try {
        // Realizamos una solicitud GET a Google (o a otro servidor confiable)
        final response = await http.get(Uri.parse('https://www.google.com'));

        // Si el código de respuesta es 200, significa que hay acceso a Internet
        if (response.statusCode == 200) {
          return true;
        }
      } catch (e) {
        // Si ocurre un error al hacer la solicitud (por ejemplo, no hay acceso a Internet), retornamos false
        return false;
      }
    }

    // Si no estamos conectados a Wi-Fi o datos móviles, devolvemos false
    return false;
  }
}
