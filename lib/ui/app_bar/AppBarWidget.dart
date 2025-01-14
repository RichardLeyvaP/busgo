
  import 'package:BusGo/domain/signals/login_signals/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

AppBar AppBarWidget( BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[200],
        statusBarIconBrightness: Brightness.dark,
      ),
      title: Row(
        children: [
          Text('Bus', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          Text('Go', style: TextStyle(color: const Color.fromARGB(255, 240, 115, 32), fontWeight: FontWeight.bold)),
        ],
      ),
      backgroundColor: Colors.grey[200],
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.black),
          onPressed: () {},
        ),
        InkWell(
          onTap: () {
            GoRouter.of(context).push('/ProfilePage');
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBwr_zZjgvmu4BccwDNIHic8K5dyehw7cSYA&s'),
            ),
          ),
        ),
        LogoutButton(),
      ],
    );
  }

  class LogoutButton extends StatelessWidget {
  void _logout(BuildContext context) {
    // Aquí puedes añadir la lógica para cerrar la sesión
    // Por ejemplo, limpiar la información de usuario y navegar a la pantalla de inicio de sesión
    logout();
 GoRouter.of(context).go(
                          '/LoginFormPage',
                        );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Salir de sesión',
      onPressed: () => _logout(context),
    );
  }
}
  
