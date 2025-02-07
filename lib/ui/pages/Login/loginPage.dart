// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:BusGo/util/util_class.dart';
import 'package:BusGo/util/utils_class_apk.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:BusGo/domain/signals/login_signals/login_service.dart';
import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:intl/intl.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:signals/signals_flutter.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // user_activity Actualizando estado
     
    });

    super.initState();
  }

  //FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  loginFuntionDeprived() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Esta función aún está en desarrollo y no está disponible en este momento')),
    );
  }

  loginFuntion() async {
    if (isLoadingLG.watch(context) == true) {
      // Muestra un mensaje de carga
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Iniciando sesión...')),
      );
    } else if (isLoggedInLG.value == false) {
      //esta vacio
      // Muestra un mensaje de carga
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginMessageLG.value)), //13295---36,000.00
      );
    } else if (isLoggedInLG.value == true) {
      //está logueado
      // Navega a la página de inicio o realiza alguna acción
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginMessageLG.value)),
      );
      
      GoRouter.of(context).go(
        '/DashboardPage'
      );
      // String date = '2024-09-09'; // La fecha puede ser dinámica
      DateTime selectedDay = DateTime.now();
      //String date = '2024-09-09'; // La fecha puede ser dinámica
      String date = DateFormat('yyyy-MM-dd').format(selectedDay);
     
      //llamar la stareas del día
      // context.read<TasksBloc>().add(TasksRequested(date)); // Pasar la fecha al evento

      //Navigator.of(context).pushReplacementNamed('/home');
    } else if (isLoginErrorLG.watch(context) == true) {
      // Muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${loginMessageLG.value}')),
      );
    }
  }

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _usserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Ejecutar una función después de que se haya renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loginFuntion();
    });
    return FadeIn(
      duration: const Duration(seconds: 2),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 10.0,
          backgroundColor: const Color.fromARGB(255, 110, 135, 206),
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(
      Icons.directions_bus,
      color: Colors.blue.shade900, // Color del ícono
    ),
    SizedBox(width: 8), // Espacio entre el ícono y el texto
    Text(
      'BusGo',
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Colors.blue.shade900,
            // Cambia alguna propiedad aqui
          ),
    ),
  ],
)

                ),
            Expanded(
                flex: 12,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white, //todo
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: _usserController,
                            decoration: InputDecoration(
                              hintText: 'Usuario',
                              hintStyle: TextStyle(color: Colors.grey.shade500), // Color del hint
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.blue.shade900, // Icono de usuario en color naranja
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200, // Fondo gris suave
                              border: InputBorder.none, // Sin borde visible
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                    width: 2.0), // Borde naranja cuando tenga foco
                                borderRadius: BorderRadius.circular(30.0), // Bordes redondeados más suaves
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent), // Sin borde cuando no tenga foco
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.red, width: 2.0), // Borde rojo en caso de error
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: _passController,
                            obscureText: _isPasswordVisible ? false : true, // Oculta el texto de la contraseña
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              hintStyle: TextStyle(color: Colors.grey.shade500), // Color del hint
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.blue.shade900, // Icono de candado en color naranja
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.blue.shade900,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200, // Fondo gris suave
                              border: InputBorder.none, // Sin borde visible
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                    width: 2.0), // Borde naranja cuando tiene foco
                                borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent), // Sin borde cuando no tiene foco
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.red, width: 2.0), // Borde rojo en caso de error
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                  onTap: () {
                                    loginFuntionDeprived();
                                  },
                                  child: Text(TranslationManager.translate('rememberPassword')))),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                                      ),
                                      backgroundColor: WidgetStateProperty.all<Color>(Colors.blue.shade900),
                                    ),
                                    onPressed: () async {
                                      if (_usserController.text.isEmpty || _passController.text.isEmpty) {
                                        _passController.clear();
                                        _usserController.clear();
                                        print('');
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text('Campos vacio,ingrese Usuario y contraseña por favor.')),
                                        );
                                      } else {
                                        login(_usserController.text, _passController.text);
                                      }
                                    },
                                    child: Text(
                                      TranslationManager.translate('loginButton'),
                                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w800),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 40,
                          //   child: SignInButton(
                          //     Buttons.google,
                          //     text: TranslationManager.translate('googleButton'),
                          //     onPressed: () {
                          //       loginFuntionDeprived();
                          //       //loginWithGoogle(context);
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(height: 12),
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 40,
                          //   child: SignInButton(
                          //     Buttons.facebook,
                          //     text: TranslationManager.translate('facebookButton'),
                          //     onPressed: () {
                          //       loginFuntionDeprived();
                          //       // loginFb(setState, context);
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
