import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:signals/signals_flutter.dart';

import 'package:BusGo/util/util_class_translation.dart';
import 'package:BusGo/domain/signals/login_signals/login_service.dart';
import 'package:BusGo/domain/signals/login_signals/login_signal.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void loginFunction() async {
    if (_userController.text.isEmpty || _passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingrese usuario y contraseña.')),
      );
      return;
    }

    await login(_userController.text, _passController.text);

    if (isLoggedInLG.value == true) {
      GoRouter.of(context).go('/DashboardPage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginMessageLG.value)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorPrimary = Colors.blueGrey.shade900;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: FadeIn(
        duration: const Duration(milliseconds: 800),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_bus_filled, size: 64, color: colorPrimary),
                  const SizedBox(height: 8),
                  Text(
                    'BusGo',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorPrimary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _userController,
                    decoration: _inputDecoration('Usuario', Icons.person, colorPrimary),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passController,
                    obscureText: !_isPasswordVisible,
                    decoration: _inputDecoration(
                      'Contraseña',
                      Icons.lock,
                      colorPrimary,
                      suffix: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                          color: colorPrimary,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        TranslationManager.translate('rememberPassword'),
                        style: TextStyle(color: colorPrimary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: colorPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: loginFunction,
                      child: Text(
                        TranslationManager.translate('loginButton'),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon, Color color, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(icon, color: color),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: 2),
      ),
    );
  }
}