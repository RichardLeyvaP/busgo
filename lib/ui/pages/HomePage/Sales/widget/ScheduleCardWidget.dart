import 'package:BusGo/domain/signals/tickets_signals/tickets_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScheduleCard extends StatefulWidget {
  final String name;
  final String origin;
  final String destination;
  final String plate;
  final String originImage;
  final String destinationImage;
  final String timeIni;
  final String timeFin;
  final String price;
  final String place;
  final int amount;
  final int seats;
  final int idTrip;
  final int seatsAvailable;
  final List<int> reservedSeats;

  const ScheduleCard(
      {super.key,
      required this.timeIni,
      required this.price,
      required this.timeFin,
      required this.place,
      required this.amount,
      required this.seats,
      required this.seatsAvailable,
      required this.idTrip,
      required this.originImage,
      required this.destinationImage,
      required this.name,
      required this.plate,
      required this.reservedSeats,
      required this.origin,
      required this.destination});

  @override
  _ScheduleCardState createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String travelTime = _calculateTravelTime(widget.timeIni, widget.timeFin);
    List<String> timeToGo = _calculateTimeToGo(widget.timeIni);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      child: InkWell(
        onTap: () {
          if (widget.seatsAvailable != 0) {
            dataSelectedRoute(widget.idTrip); // Guardar datos del viaje
            GoRouter.of(context)
                .push('/TicketPage'); // Navegar a la página de asientos
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No hay disponibilidad para este viaje'),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12), // Para efecto visual
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey, width: 0.5)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 10, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoText("Salida en:", timeToGo[0], timeToGo[1]),
                    const VerticalDivider(
                      width: 5,
                    ),
                    _infoText("Tiempo de Viaje:", travelTime, "min"),
                    const VerticalDivider(
                      width: 5,
                    ),
                    _infoText("Capacidad:", '${widget.seats}'),
                    const VerticalDivider(
                      width: 5,
                    ),
                    _infoText("Disponibles:", '${widget.seatsAvailable}'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: MediaQuery.of(context).size.width * 0.20,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _routeInfo(
                          getRegionFromAddress(
                              widget.origin), // Extraemos la región
                          "Salida: ${widget.timeIni}",
                          Icons.radio_button_checked,
                        ),
                        const SizedBox(height: 12),
                        _routeInfo(
                          getRegionFromAddress(
                              widget.destination), // Extraemos la región
                          "Llegada: ${widget.timeFin}",
                          Icons.location_on,
                          isDestination: true,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (widget.seatsAvailable != 0) {
                              dataSelectedRoute(
                                  widget.idTrip); // Guardar datos del viaje
                              GoRouter.of(context).push(
                                  '/TicketPage'); // Navegar a la página de asientos
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'No hay disponibilidad para este viaje'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text("\$${widget.price}",
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _infoText(String title, String value, [String? subtitle]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      Row(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Roboto')),
          const VerticalDivider(
            width: 0.5,
          ),
          if (subtitle != null)
            Text(" $subtitle",
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
        ],
      )
    ],
  );
}

// Widget _infoPrice(String value) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(value,
//           style: const TextStyle(
//               fontSize: 18, fontWeight: FontWeight.w900, color: Colors.orange)),
//     ],
//   );
// }

Widget _routeInfo(
  String title,
  String subtitle,
  IconData icon, {
  bool isDestination = false,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 18, color: isDestination ? Colors.orange : Colors.blue),
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            limitTextLength(title, 23),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          // Aquí aplicamos el truncado y el TextOverflow.ellipsis
          Text(
            subtitle, // Limita a 20 caracteres
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
            maxLines: 1, // Limita el texto a una sola línea
            overflow:
                TextOverflow.ellipsis, // Agrega "..." si el texto se desborda
          ),
        ],
      ),
    ],
  );
}

String limitTextLength(String text, int maxLength) {
  if (text.length > maxLength) {
    return '${text.substring(0, maxLength)}...'; // Recorta y agrega "..."
  }
  return text;
}

String getRegionFromAddress(String address) {
  // Dividimos la dirección por las comas y tomamos la última parte
  List<String> parts = address.split(',');
  // Retornamos la última parte, que sería la región
  return parts.isNotEmpty ? parts.last.trim() : '';
}

String _calculateTravelTime(String start, String end) {
  // Convertir los strings en objetos DateTime
  DateTime startTime = DateTime.parse("2024-01-01 $start:00");
  DateTime endTime = DateTime.parse("2024-01-01 $end:00");

  // Diferencia en minutos
  int minutes = endTime.difference(startTime).inMinutes;

  return "$minutes";
}

List<String> _calculateTimeToGo(String start) {
  DateTime now = DateTime.now();
  DateTime startTime = DateTime.parse(
      "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} $start:00");

  if (startTime.isBefore(now)) {
    startTime = startTime.add(const Duration(days: 1));
  }

  int minutes = startTime.difference(now).inMinutes;
  int hours = startTime.difference(now).inHours;

  if (minutes > 60) {
    return [hours.toString(), "h"]; // Retorna [valor, unidad]
  } else {
    return [minutes.toString(), "min"]; // Retorna [valor, unidad]
  }
}
