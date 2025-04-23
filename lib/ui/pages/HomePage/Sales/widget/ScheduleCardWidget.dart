import 'package:BusGo/domain/signals/tickets_signals/tickets_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';

import '../../../../../domain/signals/tickets_signals/tickets_signal.dart';
import '../../../../../models/trips/trips_model.dart';

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

  int seats = availableSeatsSignal.value;

  @override
  Widget build(BuildContext context) {
//se garantiza siempre un resultado positivo, no es la mejor forma. Hay que hacer que esto venga positivo del backend
    if (availableSeatsSignal.value < 0) {
      seats = availableSeatsSignal.value * -1;
    }

    Trip? tripForCard;
    try {
      tripForCard =
          tripsSignal.value!.firstWhere((trip) => trip.id == widget.idTrip);
    } catch (e) {
      tripForCard = null;
    }
    final displayPrice = tripForCard?.price ?? widget.price;

    List<String> timeToGo = _calculateTimeToGo(widget.timeIni);
    String travelTime = _calculateTravelTime(widget.timeIni, widget.timeFin);
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
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                    _infoText("Tiempo de Viaje:", travelTime),
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
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // spacing: MediaQuery.of(context).size.width * 0.20,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _routeInfo(
                          getRegionFromAddress(
                              widget.origin), // Extraemos la región
                          "Salida: ${_formatTime(widget.timeIni)}",
                          Icons.radio_button_checked,
                        ),
                        const SizedBox(height: 10),
                        _routeInfo(
                          getRegionFromAddress(
                              widget.destination), // Extraemos la región
                          "Llegada: ${_formatDateTime(widget.timeFin)}",
                          Icons.location_on,
                          isDestination: true,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 55, 0, 0),
                          child: ElevatedButton(
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
                            child: Text("\$$displayPrice",
                                style: const TextStyle(color: Colors.white)),
                          ),
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
      Text(title, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      Row(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 16,
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
  DateTime startTime = _safeParseDateTime(start);
  DateTime endTime = _safeParseDateTime(end);

  final duration = endTime.difference(startTime);
  final totalMinutes = duration.inMinutes;

  final hours = (totalMinutes ~/ 60).abs();
  final minutes = totalMinutes % 60;

  if (hours == 0) return '${minutes}m';
  if (minutes == 0) return '${hours}h';
  return '${hours}h ${minutes}min';
}

List<String> _calculateTimeToGo(String start) {
  DateTime now = DateTime.now();
  DateTime startTime = _safeParseDateTime(start);
  DateTime boardingEnd = startTime.subtract(const Duration(minutes: 15));

  if (now.isBefore(startTime)) {
    final difference = startTime.difference(now);
    int totalMinutes = difference.inMinutes;
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    if (hours > 0) return [hours.toString(), "h"];
    return [minutes.toString(), "min"];
  } else if (now.isBefore(boardingEnd)) {
    return ["Abordando", ""];
  } else {
    return ["Salió", ""];
  }
}

String _formatTime(String datetimeStr) {
  DateTime dt = _safeParseDateTime(datetimeStr);
  return DateFormat('HH:mm').format(dt);
}

String _formatDateTime(String datetimeStr) {
  DateTime dt = _safeParseDateTime(datetimeStr);
  return DateFormat('dd/MM/yyyy HH:mm').format(dt);
}

DateTime _safeParseDateTime(String input) {
  try {
    return DateTime.parse(input);
  } catch (_) {
    // Si falla, asumir que es solo hora y usar fecha actual
    final now = DateTime.now();
    final timeParts = input.split(':');
    return DateTime(now.year, now.month, now.day, int.parse(timeParts[0]),
        int.parse(timeParts[1]));
  }
}
