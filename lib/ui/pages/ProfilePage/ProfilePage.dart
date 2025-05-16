import 'package:BusGo/domain/signals/login_signals/login_service.dart';
import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Juan Pérez";
  String age = "30";
  String gender = "Masculino";

  bool isEditingName = false;
  bool isEditingAge = false;
  bool isEditingGender = false;

  bool isEditingPassword = false;
  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController genderController;
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: name);
    ageController = TextEditingController(text: age);
    genderController = TextEditingController(text: gender);
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildEditableField(
              "Nombre",
              name,
              isEditingName,
              nameController,
              () => setState(() => isEditingName = true),
              () => setState(() {
                name = nameController.text;
                isEditingName = false;
              }),
              () => setState(() => isEditingName = false),
            ),
            buildEditableField(
              "Edad",
              age,
              isEditingAge,
              ageController,
              () => setState(() => isEditingAge = true),
              () => setState(() {
                age = ageController.text;
                isEditingAge = false;
              }),
              () => setState(() => isEditingAge = false),
            ),
            buildEditableField(
              "Sexo",
              gender,
              isEditingGender,
              genderController,
              () => setState(() => isEditingGender = true),
              () => setState(() {
                gender = genderController.text;
                isEditingGender = false;
              }),
              () => setState(() => isEditingGender = false),
            ),
            const Divider(height: 32),
            const SizedBox(height: 20),
            if (isEditingPassword)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: currentPasswordController,
                    obscureText: !isCurrentPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Contraseña Actual",
                      suffixIcon: IconButton(
                        icon: Icon(
                          isCurrentPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isCurrentPasswordVisible = !isCurrentPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: newPasswordController,
                    obscureText: !isNewPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Nueva Contraseña",
                      suffixIcon: IconButton(
                        icon: Icon(
                          isNewPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isNewPasswordVisible = !isNewPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    passwordMessageLG.watch(context),
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          print("Contraseña actual: ${currentPasswordController.text}");
                          print("Nueva contraseña: ${newPasswordController.text}");
                          if (currentUserLG.value != null) {
                            int idUser = currentUserLG.value!.id;
                            await updatePassword(idUser, currentPasswordController.text, newPasswordController.text);
                          }
                          if(passwordTrueMessageLG.value == true)
                          {
                         ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.white), // Ícono de palomita
        SizedBox(width: 8), // Espaciado entre el ícono y el texto
        Expanded(
          child: Text(
            'Contraseña modificada correctamente',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.green, // Fondo verde
    duration: Duration(seconds: 2), // Duración del SnackBar
  ),
);



                           setState(() => isEditingPassword = false); 
                          }
                        },
                        child: const Text("Guardar"),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          passwordMessageLG.value = ''; // Mensaje en la clave 'msg'
                          setState(() => isEditingPassword = false);
                        },
                        child: const Text("Cancelar"),
                      ),
                    ],
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: () {
                  setState(() => isEditingPassword = true);
                },
                child: const Text("Cambiar Contraseña"),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField(
    String label,
    String value,
    bool isEditing,
    TextEditingController controller,
    VoidCallback onEdit,
    VoidCallback onSave,
    VoidCallback onCancel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: isEditing
                  ? TextField(controller: controller)
                  : Text(value, style: const TextStyle(fontSize: 12)),
            ),
            isEditing
                ? Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: onSave,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onCancel,
                      ),
                    ],
                  )
                : IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: onEdit,
                  ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
