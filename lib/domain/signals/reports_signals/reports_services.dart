import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/reports_signals/reports_signals.dart';
import 'package:BusGo/models/reports/report1/report1_model.dart';
import 'package:BusGo/models/reports/report2/report2_model.dart';
import 'package:BusGo/repository/reports_repository.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart'; // Ajustar según tu estructura

final reportsRepository = ReportsRepository(authService: ApiService()); // Crear repositorio si no lo tienes

Future<void> getReports1( id, type,date,endDate)  async {
  isLoadingRP.value = true; // Indicamos que está cargando
  isErrorRP.value = ""; // Limpiamos posibles errores previos

  try {
    final result = await reportsRepository.getReports1Repository(idCmpanyBranchLG.value, typeCmpanyBranchLG.value,date,endDate); // Llamada al backend

    if (result is Report1) {
      resultReport1RP.value = result; // Actualizamos las señales con los datos

    } else if (result is String) {
      isErrorRP.value = result; // Guardamos el mensaje de error si aplica
    }
  } catch (e) {
    isErrorRP.value = "Error: ${e.toString()}"; // Error inesperado
  } finally {
    isLoadingRP.value = false; // Finalizamos el estado de carga
  }
}


Future<void> getReports2( id, type,date,endDate)  async {
  isLoadingRP.value = true; // Indicamos que está cargando
  isErrorRP.value = ""; // Limpiamos posibles errores previos

  try {
    final result = await reportsRepository.getReports2Repository(idCmpanyBranchLG.value, typeCmpanyBranchLG.value,date,endDate); // Llamada al backend

    if (result is Report2) {
      resultReport2RP.value = result; // Actualizamos las señales con los datos

    } else if (result is String) {
      isErrorRP.value = result; // Guardamos el mensaje de error si aplica
    }
  } catch (e) {
    isErrorRP.value = "Error: ${e.toString()}"; // Error inesperado
  } finally {
    isLoadingRP.value = false; // Finalizamos el estado de carga
  }
}


Future<void> getReports3( id, type,date,endDate)  async {
  isLoadingRP.value = true; // Indicamos que está cargando
  isErrorRP.value = ""; // Limpiamos posibles errores previos

  try {
    final result = await reportsRepository.getReports3Repository( id, type,date,endDate); // Llamada al backend

    if (result is Report1) {
      resultReport1RP.value = result; // Actualizamos las señales con los datos

    } else if (result is String) {
      isErrorRP.value = result; // Guardamos el mensaje de error si aplica
    }
  } catch (e) {
    isErrorRP.value = "Error: ${e.toString()}"; // Error inesperado
  } finally {
    isLoadingRP.value = false; // Finalizamos el estado de carga
  }
}