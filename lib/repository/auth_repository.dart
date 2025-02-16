
import 'package:BusGo/models/login/login_model.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:BusGo/env.dart';

class AuthRepository {
  final ApiService authService;

  AuthRepository({required this.authService});



Future loginNew(String email, String password) async {
  final url = Uri.parse('${Env.apiEndpoint}/login-apk');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final body = jsonDecode(response.body); // ✅ Decodifica correctamente el JSON
    final state = response.statusCode;

    print('si estoy devolviendo esto:1-$body');

    if (body.containsKey('token')) {
      final user = Login(
        image: body['image'] as String,
        name: body['name'] as String,
        nameRole: body['nameRole'] as String,
        roleId: body['roleId'] as int,
        workerId: body['workerId'] as int,
        id: body['id'] as int,
        userName: body['userName'] as String,
        email: body['email'] as String,
        token: body['token'] as String,
        branch: Branch.fromJson(body['branch'] as Map<String, dynamic>),
      );

      authService.setToken(body['token']);
      return user;
    } else if (body.containsKey('msg')) {
      return body['msg'] as String;
    } else {
      print('aqui estoy entrando-error');
      throw Exception('Token no presente en la respuesta');
    }
  } catch (error) {
    throw Exception('Error en la petición: $error');
  }
}

  
  Future updatePasswordRepo(int idUser, String currentPassword, String newPassword) async {
    
    try {
      // Hacemos la petición HTTP POST con las credenciales de usuario
       final response = await authService.updatePasswordServ( idUser,  currentPassword,  newPassword);
     
        // Si hubo un error en la respuesta de la API
        return response;
      
    } catch (error) {
      // Si hubo un error durante la petición
      throw Exception('Token no presente en la respuesta');
    }
  }

  Future<dynamic> login(String email, String password) async {
    // Llama al servicio que maneja la API de autenticación para login
    final response = await authService.loginWithCredentials(email, password);
    // Extrae el token del Map<String, dynamic>
    // Crea una instancia de `Login` con los datos de la respuesta de la API
final body = response['body'];
final state = response['statusCode'];
    print('si estoy devolviendo esto:1-$response');

    if (body.containsKey('token')) {

      final user = Login(        
        image: body['image'] as String,
        name: body['name'] as String,
        nameRole: body['nameRole'] as String,
        roleId: body['roleId'] as int,
        workerId: body['workerId'] as int,        
        id: body['id'] as int,
        userName: body['userName'] as String,
        email: body['email'] as String,
        token: body['token'] as String,
        branch: Branch.fromJson(body['branch'] as Map<String, dynamic>), // ✅ Conversión correcta
      );

      authService.setToken(body['token']);

      // Crear objeto User a partir de la respuesta
      //  final user = Login.fromJson(response['user']);//esto no esta probado
      return user;
    } else if (response.containsKey('msg')) {
      return response['msg'] as String;
    } else {
      print('aqui estoy entrando-error');
      throw Exception('Token no presente en la respuesta');
    }
  }

  Future<String> loginWithFacebook(String token) async {
    // Llama al servicio que maneja la autenticación de Facebook
    final response = await authService.loginWithTokenFacebook(token);
    if (response.containsKey('token')) {
      return response['token'] as String; // Asegúrate de que es un String
    } else {
      throw Exception('Token no presente en la respuesta');
    }
  }

  Future<String> loginWithGoogle(String token) async {
    // Llama al servicio que maneja la autenticación de Google
    final response = await authService.loginWithTokenGoogle(token);
    
    
    if (response.containsKey('token')) {
      return response['token'] as String; // Asegúrate de que es un String
    } else {
      throw Exception('Token no presente en la respuesta');
    }
  }

  Future<dynamic> logout( ) async {
    // Llama al servicio para cerrar sesión
   return authService.logout();
  }
}
