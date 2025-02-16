import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String? baseUrl;
  String? _token; // Token privado

  ApiService({this.baseUrl, String? token}) : _token = token;

  // Método para establecer el token
  Future<void> setToken(String? token) async {
    _token = token;
    print('el token es:$token -setToken');
    // Guardar el token en shared_preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token ?? '');
  }

  // Método para obtener el token
  Future<String?> getToken() async {
    if (_token != null) {
      return _token;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('auth_token');
      return _token;
    }
  }

  // Método general para iniciar sesión
  Future<Map<String, dynamic>> login({
    String? facebookToken,
    String? googleToken,
    String? username,
    String? password,
  }) async {
    if (facebookToken != null) {
      return loginWithTokenFacebook(facebookToken);
    } else if (googleToken != null) {
      return loginWithTokenGoogle(googleToken);
    } else if (username != null && password != null) {
      return loginWithCredentials(username, password);
    } else {
      throw Exception('Datos de autenticación insuficientes.');
    }
  }

  // Método GET
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: await _headers(),
    );
    print('mandando para el get-empoint:$endpoint');
    return _processResponse(response);
  }

  // Método POST
  Future<dynamic> post(String endpoint, {required Map<String, dynamic> body}) async {
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: await _headers(),
        body: jsonEncode(body),
      );
      print('aqui estoy entrando-al metodo-post-task-response.statusCode${response.statusCode}');

      return _processResponse(response);
    } on SocketException catch (e) {
      print('Error de red (SocketException): $e');
      throw Exception('Error de red: No se pudo conectar al servidor.');
    } on HttpException catch (e) {
      print('Error HTTP (HttpException): $e');
      throw Exception('Error HTTP: La solicitud al servidor falló.');
    } on FormatException catch (e) {
      print('Error de formato (FormatException): $e');
      throw Exception('Error de formato: La respuesta no tiene un formato esperado.');
    } catch (e, stacktrace) {
      print('Error general (Exception): $e');
      print('Stacktrace: $stacktrace');
      throw Exception('Error desconocido: $e');
    }
  }

  // Método PUT
  Future<dynamic> put(String endpoint, {required Map<String, dynamic> body}) async {
    print('_onConfigurationSubmitted entrando Future<dynamic> put:${body}');
    final response = await http.put(
      Uri.parse(endpoint),
      headers: await _headers(),
      body: jsonEncode(body),
    );
    print('_onConfigurationSubmitted entrando Future<dynamic> response:${response.body}');
    return _processResponse(response);
  }

  // Método DELETE
  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _headers(),
    );
    return _processResponse(response);
  }

  // Método para obtener los encabezados
  Future<Map<String, String>> _headers() async {
    //final token = 'ghjhjhkjghjgjh'; //SIMULANDO UN TOKEN MAL
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
    };
    headers['Authorization'] = 'Bearer $token';
    print('mandando para el get-geader:${token}');
    return headers;
  }

// Método para procesar la respuesta
 dynamic _processResponse(http.Response response) {
  print('entrando a * - : getCategoriesPriority-3:${response.statusCode}');

  // Variable para almacenar la respuesta procesada
  dynamic responseBody;

  switch (response.statusCode) {
    case 200:
    case 201: // 201 indica que se realizó correctamente y se creó algo
      responseBody = jsonDecode(response.body);
      break;
    case 204: // 204 indica que no hay contenido
      responseBody = 'No hay resultados';
      break;
    case 400:
    case 401: // Errores de cliente
      responseBody = jsonDecode(response.body);
      break;
    case 404:
      responseBody = 'No encontró la dirección statusCode:404';
      break;
    default:
      throw Exception('_processResponse():statusCode:${response.statusCode} llamando a la ruta:${response.request}');
  }

  // Retorna un mapa con el cuerpo y el código de estado
  return {
    'body': responseBody,
    'statusCode': response.statusCode,
  };
}


  // Método para iniciar sesión con usuario y contraseña
  Future<Map<String, dynamic>> loginWithCredentials(String username, String password) async {
    print('aqui estoy entrando... 1');
    final endpoint = 'http://busgo.api.wezen.cl/api/login-apk';
    final body = {
      'email': username,
      'password': password,
    };
    print('aqui estoy entrando... 2');
    try {
      // Realiza la solicitud POST

      // Procesa la respuesta
      return await post(endpoint, body: body);
    } catch (e) {
      // Manejo de errores específico para el login
      print('Error en el login: $e');
      throw Exception('Error en el login:$e');
    }
  }
    // Método para iniciar sesión con usuario y contraseña
  Future<Map<String, dynamic>> updatePasswordServ(int idUser, String currentPassword, String newPassword) async {
    print('aqui estoy entrando... 1');
    final endpoint = 'http://busgo.api.wezen.cl/api/update-password';
    final body = {
      'id': idUser,
          'currentPassword': currentPassword,
          'newPassword': newPassword,
    };
    print('aqui estoy entrando... 2');
    try {
      // Realiza la solicitud POST
      // Procesa la respuesta
      return await post(endpoint, body: body);
  
  
    } catch (e) {
      // Manejo de errores específico para el login
      print('Error en el login: $e');
      throw Exception('Error en el login:$e');
    }
  }

// Método para iniciar sesión con un token de terceros (Google)
  Future<Map<String, dynamic>> loginWithTokenGoogle(String thirdPartyToken) async {
    final endpoint = '/google-callback-apk'; // Asegúrate de que este endpoint sea correcto
    final body = {
      'token': thirdPartyToken,
    };

    try {
      // Realiza la solicitud POST
      final response = await post(endpoint, body: body);

      // Procesa la respuesta
      final data = _processResponse(response);

      // Asignar el token al recibir la respuesta, si es necesario
      if (data.containsKey('token')) {
        _token = data['token'];
      } else {
        throw Exception('El token no está presente en la respuesta');
      }

      return data;
    } catch (e) {
      // Manejo de errores específico para el login con Google
      print('Error en el login con Google: $e');
      throw Exception('Error en el login con Google:$e');
    }
  }

  // Método para iniciar sesión con un token de terceros (Facebook)
  Future<Map<String, dynamic>> loginWithTokenFacebook(String thirdPartyToken) async {
    final endpoint = '/facebook-callback-apk'; // Asegúrate de que este endpoint sea correcto
    final body = {
      'token': thirdPartyToken,
    };

    try {
      // Realiza la solicitud POST
      final response = await post(endpoint, body: body);

      // Procesa la respuesta
      final data = _processResponse(response);

      // Asignar el token al recibir la respuesta, si es necesario
      if (data.containsKey('token')) {
        _token = data['token'];
      } else {
        throw Exception('El token no está presente en la respuesta');
      }

      return data;
    } catch (e) {
      // Manejo de errores específico para el login con Facebook
      print('Error en el login con Facebook: $e');
      throw Exception('Error en el login con Facebook:$e');
    }
  }

  // Método para hacer logout
  Future<dynamic> logout( ) async {
    final endpoint = 'http://busgo.api.wezen.cl/api/logout';
   
    print('aqui estoy entrando... 2');
    try {
      // Realiza la solicitud POST
 // También puedes limpiar la variable local si lo deseas
    _token = null;
      // Procesa la respuesta
      return await get(endpoint);
      
    } catch (e) {
      // Manejo de errores específico para el login
      print('Error en el login: $e');
      throw Exception('Error en el login:$e');
    }
  
  }
}
