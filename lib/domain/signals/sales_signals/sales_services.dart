import 'package:BusGo/domain/signals/sales_signals/sales_signals.dart';
import 'package:BusGo/models/sales/sales_model.dart';
import 'package:BusGo/repository/sales_repository.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart'; // Ajustar según tu estructura

final tripsRepository = SalesRepository(authService: ApiService()); // Crear repositorio si no lo tienes

Future<void> getSales( branchId, type,month)  async {
  isLoadingSL.value = true; // Indicamos que está cargando
  isErrorSL.value = ""; // Limpiamos posibles errores previos

  try {
    final result = await tripsRepository.getSalesRepository(branchId,type,month); // Llamada al backend

    if (result is Sales) {
      resultSalesSL.value = result; // Actualizamos las señales con los datos

print('resultSalesSL: ${resultSalesSL.value}');
    } else if (result is String) {
      isErrorSL.value = result; // Guardamos el mensaje de error si aplica
    }
  } catch (e) {
    isErrorSL.value = "Error: ${e.toString()}"; // Error inesperado
  } finally {
    isLoadingSL.value = false; // Finalizamos el estado de carga
  }
}