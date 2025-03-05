import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/ui/pages/HomePage/Sales/widget/AppBarWidget.dart';
import 'package:BusGo/ui/pages/HomePage/Sales/widget/ScheduleCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          children: [
            // Header con imagen y título
            AppBarSalesWidget(),
            // Card para detalles "From" y "To"
            Expanded(  // Añadimos Expanded para que ocupe el espacio restante
              child: Container(//container de afuera
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                         // SizedBox(height: 10),
                         // ContainerSourceDestinationWidget(),
                          SizedBox(height: 20),
                          tripsSignal.watch(context) == null || tripsSignal.watch(context)!.isEmpty
                              ? Center(
                                  child: Text(
                                    "No hay recorridos disponibles",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: tripsSignal.watch(context)!.length,
                                  itemBuilder: (context, index) {
                                    final trip = tripsSignal.watch(context)![index];
                                   availableSeatsSignal.value = trip.seats! - (trip.reservedSeats!.length);
                                    return ScheduleCard(
                                      name: trip.name??'' ,
                                      origin: trip.origin??"Desconocido" ,
                                      destination: trip.destination??"Desconocido" ,
                                      plate: trip.plate??'' ,
                                      originImage: trip.originImage??'' ,
                                      destinationImage: trip.destinationImage??'' ,
                                      timeIni: trip.schedule.toString(),
                                      timeFin: trip.arrival.toString(),
                                      price: trip.price== null?trip.price.toString(): "0.0",
                                      place: trip.name ?? "Desconocido",
                                      amount: trip.seats ?? 0,
                                      seats: trip.seats ?? 0,
                                      seatsAvailable: availableSeatsSignal.value,//-ojo-verificar si fuera null que no de error
                                      idTrip: trip.id??0,
                                      reservedSeats: trip.reservedSeats??[],

                                    );
                                  },
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
