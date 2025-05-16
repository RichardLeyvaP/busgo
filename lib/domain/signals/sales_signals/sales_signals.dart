
import 'package:BusGo/models/sales/sales_model.dart';
import 'package:signals/signals.dart';

// Definimos las señales
final Signal<bool?> isLoggedInSL = Signal<bool?>(null);
final Signal<Sales?> resultSalesSL = Signal<Sales?>(null); // Usuario actual
final Signal<bool> isLoadingSL = Signal<bool>(false); // Estado de carga
final Signal<String> isErrorSL = Signal<String>(""); // Estado de carga

// Señal para el destino seleccionado (inicialmente null = mostrar todos)
final Signal<String?> selectedDestinationSignal = Signal<String?>(null);
