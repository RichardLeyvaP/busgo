import 'package:BusGo/models/login/login_model.dart';
import 'package:BusGo/repository/auth_repository.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_signal.dart';

// Este es el servicio que maneja la lógica de login

final authRepository = AuthRepository(authService: ApiService());
// Método para hacer login
Future<void> login(String email, String password) async {
  isLoadingLG.value = true; // Indicamos que está cargando
  isLoginErrorLG.value = false; // Indicamos inicialmente que no hay error
  isLoggedInLG.value = null; // Indicamos inicialmente que es null

  try {
    final result = await authRepository.loginNew(email, password);
    isLoadingLG.value = false; // Detenemos el loading

    if (result is String) {
      loginMessageLG.value = result; // Si es un mensaje de error
      isLoggedInLG.value = false;
    } else if (result is Login) {
      currentUserLG.value = result; // Guardamos el usuario
      //aqui para guardar la branch
      currentUserBranchLG.value = currentUserLG.value?.branch;
      //aqui para guardar la company
      currentUserBranchCompanyLG.value = currentUserLG.value?.branch.company;
      if (result.nameRole == 'Administrador') {
        typeCmpanyBranchLG.value = 'Company';
        idCmpanyBranchLG.value = currentUserBranchCompanyLG.value!.id;
      } else {
        typeCmpanyBranchLG.value = 'Sucursal';
        idCmpanyBranchLG.value = currentUserBranchLG.value!.id;
      }

      isLoggedInLG.value = true; // El usuario ha iniciado sesión correctamente
      loginMessageLG.value = "Login successful";
    }
  } catch (e) {
    isLoginErrorLG.value = true;
    isLoadingLG.value = false;
    loginMessageLG.value = "Error: ${e.toString()}"; // Si ocurre un error
  }
}

//updatePassword
// Método para cambiar la contrasena
Future<void> updatePassword(
    int idUser, String currentPassword, String newPassword) async {
  isLoadingLG.value = true; // Indicamos que está cargando

  try {
    final result = await authRepository.updatePasswordRepo(
        idUser, currentPassword, newPassword);
    isLoadingLG.value = false; // Detenemos el loading
    passwordTrueMessageLG.value = false;

    if (result.containsKey('body')) {
      final body = result['body']; // Extraemos el mapa contenido en 'body'

      if (body.containsKey('details')) {
        passwordMessageLG.value =
            body['details'][0]; // Mensaje de la lista 'details'
      } else if (body.containsKey('msg')) {
        if (result.containsKey('statusCode')) {
          if (result['statusCode'] == 200) {
            passwordTrueMessageLG.value = true;
            passwordMessageLG.value = ''; // Mensaje en la clave 'msg'
          } else {
            passwordMessageLG.value = body['msg']; // Mensaje en la clave 'msg'
          }
        }
      } else {
        print("El JSON no contiene las claves 'details' o 'msg'.");
      }
    } else {
      print("El resultado no contiene la clave 'body'.");
    }
  } catch (e) {
    passwordMessageLG.value = "Error: ${e.toString()}";
    isLoadingLG.value = false;
    loginMessageLG.value = "Error: ${e.toString()}"; // Si ocurre un error
  }
}

// Método para hacer logout
Future<void> logout() async {
  // isLoadingLG.value = true; // Indicamos que está cargando
  isLoginErrorLG.value = false; // Indicamos inicialmente que no hay error
  isLoggedInLG.value = null; // Indicamos inicialmente que es null

  try {
//     final result = await authRepository.logout();
// print(result);
// print(result.runtimeType); // Esto imprime el tipo de datos de result

    // isLoadingLG.value = false; // Detenemos el loading
    // Eliminar el token de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Eliminar el token de SharedPreferences
    await prefs.remove('auth_token');

    print('Sesión cerrada y token eliminado');
    // Asumimos que 'result' es la respuesta del backend, procesada aquí:
    //  final Map<String, dynamic> responseMap = result; // Verificamos si el map contiene la clave 'msg' o 'error'
    //  if (responseMap.containsKey('msg')) {
    //    loginMessageLG.value = responseMap['msg']; }
    //    else if (responseMap.containsKey('error'))
    //    { loginMessageLG.value = responseMap['error']; }
    //    else { loginMessageLG.value = 'Respuesta inesperada del servidor'; }

    isLoggedInLG.value = false;
  } catch (e) {
    isLoginErrorLG.value = true;
    isLoadingLG.value = false;
    loginMessageLG.value = "Error: ${e.toString()}"; // Si ocurre un error
  }
}

void clearLoginSignals() {
  // Restablecer las señales a sus valores predeterminados
  isLoggedInLG.value = null;
  loginMessageLG.value = "";
  currentUserLG.value = null;
  isLoadingLG.value = false;
  isLoginErrorLG.value = false;
}

void logoutAndClearSignals() {
  // Limpiar señales de login
  clearLoginSignals();
}
