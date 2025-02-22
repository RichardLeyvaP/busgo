
import 'package:BusGo/models/reports/report1/report1_model.dart';
import 'package:BusGo/models/reports/report2/report2_model.dart';
import 'package:signals/signals.dart';

// Definimos las señales
final Signal<bool?> isLoggedInRP = Signal<bool?>(null);
final Signal<bool> isLoadingRP = Signal<bool>(false); // Estado de carga
final Signal<String> isErrorRP = Signal<String>(""); // Estado de carga
final Signal<Report1?> resultReport1RP = Signal<Report1?>(null); // Estado de carga
final Signal<Report2?> resultReport2RP = Signal<Report2?>(null); // Estado de carga


