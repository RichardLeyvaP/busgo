import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/ui/pages/HomePage/Sales/widget/AppBarWidget.dart';
import 'package:BusGo/ui/pages/HomePage/Sales/widget/ScheduleCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../../../domain/signals/login_signals/login_signal.dart';
import '../../../../domain/signals/sales_signals/sales_signals.dart';

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final branchName = currentUserBranchLG.value?.name ?? "Sucursal no asignada";
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          children: [
            // Header con imagen y título
             AppBarSalesWidget(
              origen: branchName,
            ),
            // Card para detalles "From" y "To"
            Expanded(
              // Añadimos Expanded para que ocupe el espacio restante
              child: Container(
                //container de afuera
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          const Text(
                            'Viajes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          // SizedBox(height: 10),
                          // ContainerSourceDestinationWidget(),
                          const SizedBox(height: 20),
                          tripsSignal.watch(context) == null ||
                                  tripsSignal.watch(context)!.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No hay recorridos disponibles",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : Watch((_) {
                            final trips = tripsSignal.value ?? [];
                            final selectedDestination = selectedDestinationSignal.value;


                            final filteredTrips = selectedDestination != null
                                ? trips.where((trip) => trip.destination == selectedDestination).toList()
                                : trips;

                            if (filteredTrips.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    "No hay viajes disponibles",
                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                  ),
                                ),
                              );
                            }


                            return
                            ListView.builder(
                              shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredTrips.length,
                              itemBuilder: (context, index) {

                                final trip = filteredTrips[index];
                                final availableSeats = trip.seats! - (trip.reservedSeats?.length ?? 0);
                                availableSeatsSignal.value = trip.seats! -
                                    (trip.reservedSeats!.length);
                                return ScheduleCard(
                                  name: trip.name ?? '',
                                  origin: trip.origin ?? "Desconocido",
                                  destination:
                                  trip.destination ?? "Desconocido",
                                  plate: trip.plate ?? '',
                                  originImage: trip.originImage ?? '',
                                  destinationImage:
                                  trip.destinationImage ?? '',
                                  timeIni: trip.schedule.toString(),
                                  timeFin: trip.arrival.toString(),
                                  price: trip.price == null
                                      ? trip.price.toString()
                                      : "0.0",
                                  place: trip.name ?? "Desconocido",
                                  amount: trip.seats ?? 0,
                                  seats: trip.seats ?? 0,
                                  seatsAvailable: availableSeats,
                                      // .value,
                                  //-ojo-verificar si fuera null que no de error
                                  idTrip: trip.id ?? 0,
                                  reservedSeats: trip.reservedSeats ?? [],
                                );
                              },
                            );

                          }
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
