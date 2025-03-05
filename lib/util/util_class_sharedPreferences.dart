import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage {
  static const String _key = 'TicketSavedLocally';

  // Obtener el valor actual
  Future<int> getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 0;
  }

  // Aumentar en 1
  Future<void> incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int current = prefs.getInt(_key) ?? 0;
    await prefs.setInt(_key, current + 1);
  }

  // Disminuir en 1
  Future<void> decrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int current = prefs.getInt(_key) ?? 0;
    if (current > 0) {
      await prefs.setInt(_key, current - 1);
    }
  }

  // Reiniciar a 0
  Future<void> resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, 0);
  }

  // Actualizar el valor con el entero proporcionado
Future<void> updateCounter(int newValue) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_key, newValue);
}

}
