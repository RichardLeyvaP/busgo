import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerModal extends StatefulWidget {
  final Function(String) onDateSelected;

  const DatePickerModal({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DatePickerModalState createState() => _DatePickerModalState();
}

class _DatePickerModalState extends State<DatePickerModal> {
  String? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Retrasar la apertura del calendario para que se ejecute después del primer renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openDatePicker();
    });
  }

  void _openDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _selectedDate = formattedDate;
      });
      widget.onDateSelected(formattedDate);
      Navigator.of(context).pop(); // Cierra el modal después de seleccionar la fecha
    }
  }

  

    @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
