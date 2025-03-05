import 'package:BusGo/myApp/MyApp.dart';
import 'package:BusGo/util/util_class_translation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await initializeDateFormatting('es', null);
  await TranslationManager.loadDefaultTranslations('es'); // Asegúrate de pasar el idioma correcto.

  runApp(MyApp());
}
