
import 'package:signals/signals.dart';

// Signals para manejar el estado
final Signal<int> quantitySignal = Signal<int>(1); // Inicia en 1
final Signal<List<int>> selectedSeatNumbersSN = Signal<List<int>>([]); // Inicia en 1

final Signal<bool> isLoadingSignalPR = Signal<bool>(false);
final Signal<String?> productErrorSignal = Signal<String?>(null);
final Signal<String?> productEmpySignal = Signal<String?>(null);
final Signal<String> submitErrorSignal = Signal<String>("");

final Signal<bool> isProductSubmittingSignal = Signal<bool>(false);
final Signal<bool> productSubmittedSuccessSignal = Signal<bool>(false);

final Signal<bool> isUpdateProductSignal = Signal<bool>(false);
