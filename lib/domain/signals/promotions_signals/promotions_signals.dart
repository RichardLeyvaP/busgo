import 'package:BusGo/models/promotions/promotions_model.dart';
import 'package:signals/signals.dart';

/// Contiene la lista completa que recibes del backend
final Signal<List<Promotion>?> promotionSignal = Signal<List<Promotion>?>(null);

/// Guarda para cada categoría la promoción seleccionada (null = ninguna)
final Signal<Promotion?> promotionMenoresSignal  = Signal<Promotion?>(null);
final Signal<Promotion?> promotionNormalSignal   = Signal<Promotion?>(null);
final Signal<Promotion?> promotionAdultSignal    = Signal<Promotion?>(null);
