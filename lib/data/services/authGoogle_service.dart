import 'dart:convert';

import 'package:BusGo/env.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

Future<void> loginWithGoogle(context) async {
  print('resp1- loginWithGoogle()');
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      print('resp1- loginWithGoogle():idToken:(googleUser != null)');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Verifica si idToken es nulo
      if (googleAuth.idToken != null) {
        String idToken = googleAuth.idToken!;
        //  print('resp1- loginWithGoogle():idToken:$idToken');
        print('resp1- loginWithGoogle():Name:${googleUser.displayName}');
        print('resp1- loginWithGoogle():photo:${googleUser.photoUrl}');
        // Ahora, manda este token a tu API Laravel
        //  await _sendTokenToApi(idToken);
        Map<String, dynamic> userData = {
          'name': googleUser.displayName,
          'email': googleUser.email,
          'pictureUrl': googleUser.photoUrl,
        };

        GoRouter.of(context).go(
          '/HomePrincipal'
        );
        _googleSignIn.signOut();
      } else {
        print('resp1- loginWithGoogle():idToken:ERROR:idToken es null');
      }
    }
  } catch (error) {
    print('resp1- loginWithGoogle():idToken:ERROR:$error');
    print(error);
  }
}

Future<bool> signOutFromGoogle() async {
  try {
    await _googleSignIn.signOut();
    return true;
  } on Exception catch (_) {
    return false;
  }
}

Future<void> _sendTokenToApi(String idToken) async {
  final response = await http.post(
    Uri.parse('${Env.apiEndpoint}/auth/google-login'),
    body: {
      'id_token': idToken,
    },
  );

  if (response.statusCode == 200) {
    // Login exitoso
    print('Login exitoso');
    final data = json.decode(response.body);
    // Aquí puedes manejar la respuesta, como guardar el token de sesión o navegar a otra página
    await _saveToken(data['token']);
  } else {
    // Error en el login
    print('Error al iniciar sesión: ${response.body}');
  }
}

Future<void> _saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

/*goToHomeG(Map<String, dynamic> userData, context) {
  final userCubit = context.read<RoutesCubit>();
  print('llegando a la pagina de goToHomeG');
  print('llegando a la pagina de goToHomeG-name:${userData['name']}');
  userCubit.goHomeFb(
    name: userData['name'],
    email: userData['email'],
    avatarUrl: userData['pictureUrl'],
  );
}*/





// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<void> loginWithGoogle() async {
//   print('resp- entrando a loginWithGoogle');
//   final url = Uri.parse('http://192.168.1.2:8000/api/login-google'); // URL de tu API
//   try {
//     final response = await http.get(
//       url,
//       /* body: {
//         'google_token': 'aquí va el token de google',
//       },*/
//     );
//     // Imprime la respuesta completa
//     print('resp- Response body: ${response.body}');
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       // Maneja la respuesta de la API, como los datos del usuario o token
//       print('resp- Login exitoso: $responseData');
//     } else {
//       print('resp- Error al iniciar sesión: ${response.statusCode}');
//     }
//   } catch (error) {
//     print('resp- Error en la solicitud: $error');
//   }
// }
