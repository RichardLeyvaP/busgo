
import 'dart:ffi';

import 'package:BusGo/models/trips/trips_model.dart';
import 'package:signals/signals.dart';

// Signals para manejar el estado
final Signal<int> quantitySignal = Signal<int>(0); // Inicia en 1
final Signal<int> availableSeatsSignal = Signal<int>(0); // Inicia en 1
final Signal<int> quantityMenoresSignal = Signal<int>(0); // Inicia en 1
final Signal<List<int>> selectedSeatNumbersSN = Signal<List<int>>([]); // Inicia en 1
final Signal<Trip?> tripsSelectSignal = Signal<Trip?>(null);


final Signal<bool> isLoadingSignalPR = Signal<bool>(false);
final Signal<String?> productErrorSignal = Signal<String?>(null);
final Signal<String?> productEmpySignal = Signal<String?>(null);
final Signal<String> submitErrorSignal = Signal<String>("");

final Signal<bool> isProductSubmittingSignal = Signal<bool>(false);
final Signal<bool> productSubmittedSuccessSignal = Signal<bool>(false);

final Signal<bool> isUpdateProductSignal = Signal<bool>(false);

// Señales relacionadas con Trips
final Signal<bool> isLoadingTripsSignal = Signal<bool>(false);
final Signal<List<Trip>?> tripsSignal = Signal<List<Trip>?>(null);
final Signal<String?> tripsErrorSignal = Signal<String?>(null);





