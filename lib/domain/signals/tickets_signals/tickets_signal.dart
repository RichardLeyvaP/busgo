

import 'package:BusGo/models/promotions/promotions_model.dart';
import 'package:BusGo/models/ticket/tickets_model.dart';
import 'package:BusGo/models/trips/trips_model.dart';
import 'package:signals/signals.dart';

// Signals para manejar el estado
final Signal<int> quantitySignal = Signal<int>(0); // Inicia en 1
final Signal<int> availableSeatsSignal = Signal<int>(0); // Inicia en 1
final Signal<int> quantityMenoresSignal = Signal<int>(0); // Inicia en 1
final Signal<int> quantityAdultsSignal = Signal<int>(0); // Inicia en 1
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
final totalToPaySignal = Signal<double>(0.0);
final promotionsSelectedSignal = Signal<Map<String, Promotion?>>({});
// Señales relacionadas con Tickets
final Signal<bool> isLoadingTicketsSignal = Signal<bool>(false);
final Signal<bool> floatingActionButtonSignal = Signal<bool>(true);
final Signal<List<Ticket>?> ticketsSignal = Signal<List<Ticket>?>(null);
final Signal<String?> ticketsErrorSignal = Signal<String?>(null);






