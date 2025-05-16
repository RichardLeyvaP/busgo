import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  final Future<void> Function() taskToExecute;

  const LoadingDialog({Key? key, required this.taskToExecute}) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  String _message = 'Actualizando datos...'; // Mensaje inicial

  @override
  void initState() {
    super.initState();
    _executeTask();
  }

  // Ejecutar la tarea proporcionada
  Future<void> _executeTask() async {
    // Mostrar el modal y esperar la tarea
    await widget.taskToExecute();

    // Cambiar mensaje después de la tarea
    setState(() {
      _message = 'Finalizando...';
    });

    // Esperar 2 segundos y cerrar el modal
    await Future.delayed(const Duration(seconds: 2));

    // Cerrar el modal
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Expanded(
              child: Text(_message),
            ),
          ],
        ),
      ),
    );
  }
}

// Método para mostrar el LoadingDialog
void showLoadingDialog(BuildContext context, Future<void> Function() taskToExecute) {
  showDialog(
    context: context,
    barrierDismissible: false, // No permitir cerrar tocando fuera del modal
    builder: (BuildContext context) {
      return LoadingDialog(taskToExecute: taskToExecute);
    },
  );
}
