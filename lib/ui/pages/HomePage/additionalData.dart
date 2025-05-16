import 'package:flutter/material.dart';

class AdditionalDataWidget extends StatefulWidget {
  final Function(String device, String description, int dteType, String contact) onDataChanged;

  const AdditionalDataWidget({Key? key, required this.onDataChanged}) : super(key: key);

  @override
  _AdditionalDataWidgetState createState() => _AdditionalDataWidgetState();
}

class _AdditionalDataWidgetState extends State<AdditionalDataWidget> {
  bool _isExpanded = false;

  // Controladores para los campos de texto
  TextEditingController deviceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dteTypeController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  void dispose() {
    deviceController.dispose();
    descriptionController.dispose();
    dteTypeController.dispose();
    contactController.dispose();
    super.dispose();
  }

  void _updateValues() {
    widget.onDataChanged(
      deviceController.text,
      descriptionController.text,
    int.tryParse(dteTypeController.text) ?? 0,
      contactController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Datos Adicionales",
                style: TextStyle(fontSize: 12, ),
              ),
              Icon(
                _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.blue,
              ),
            ],
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 8),
          _buildTextField("Dispositivo", deviceController),
          _buildTextField("Descripción", descriptionController),
          _buildTextField("Tipo de Dte", dteTypeController),
          _buildTextField("Contacto", contactController),
        ],
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        onChanged: (value) => _updateValues(),
      ),
    );
  }
}
