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

  const ScheduleCard({
    super.key,
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
    required this.destination,
  });

  @override
  _ScheduleCardState createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Calculamos si ya "Salió"
    final List<String> timeToGo = _calculateTimeToGo(widget.timeIni);
    final bool isTimeExceeded = timeToGo[0] == "Salió";

    // Obtenemos precio actualizado si existe en signal
    Trip? tripForCard;
    try {
      tripForCard =
          tripsSignal.value!.firstWhere((trip) => trip.id == widget.idTrip);
    } catch (e) {
      tripForCard = null;
    }
    final String displayPrice = tripForCard?.price ?? widget.price;

    // Tiempo de viaje
    final String travelTime =
        _calculateTravelTime(widget.timeIni, widget.timeFin);

    // El contenedor padre: si está excedido, absorbemos todos los gestos
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      child: isTimeExceeded
          ? AbsorbPointer(
              child: _buildCardContent(
                  displayPrice, timeToGo, travelTime, isTimeExceeded))
          : InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                if (widget.seatsAvailable > 0) {
                  dataSelectedRoute(widget.idTrip);
                  GoRouter.of(context).push('/TicketPage');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('No hay disponibilidad para este viaje')),
                  );
                }
              },
              child: _buildCardContent(
                  displayPrice, timeToGo, travelTime, isTimeExceeded),
            ),
    );
  }

  Widget _buildCardContent(
    String displayPrice,
    List<String> timeToGo,
    String travelTime,
    bool isTimeExceeded,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fila de info superior
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoText("Salida en:", timeToGo[0], timeToGo[1]),
                const VerticalDivider(width: 5),
                _infoText("Tiempo de Viaje:", travelTime),
                const VerticalDivider(width: 5),
                _infoText("Capacidad:", '${widget.seats}'),
                const VerticalDivider(width: 5),
                _infoText("Disponibles:", '${widget.seatsAvailable}'),
              ],
            ),

            const SizedBox(height: 5),

            // Fila de ruta y botón
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Datos de origen/destino
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _routeInfo(
                      getRegionFromAddress(widget.origin),
                      "Salida: ${_formatTime(widget.timeIni)}",
                      Icons.radio_button_checked,
                    ),
                    const SizedBox(height: 10),
                    _routeInfo(
                      getRegionFromAddress(widget.destination),
                      "Llegada: ${_formatDateTime(widget.timeFin)}",
                      Icons.location_on,
                      isDestination: true,
                    ),
                  ],
                ),

                // Botón de precio
                Padding(
                  padding: const EdgeInsets.only(top: 55),
                  child: ElevatedButton(
                    onPressed: isTimeExceeded || widget.seatsAvailable == 0
                        ? null
                        : () {
                            dataSelectedRoute(widget.idTrip);
                            GoRouter.of(context).push('/TicketPage');
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isTimeExceeded ? Colors.grey : Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "\$$displayPrice",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Resto de helpers sin cambios:
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
          const VerticalDivider(width: 0.5),
          if (subtitle != null)
            Text(" $subtitle",
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
        ],
      ),
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
          Text(limitTextLength(title, 23),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(subtitle,
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    ],
  );
}

String limitTextLength(String text, int maxLength) {
  return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
}

String getRegionFromAddress(String address) {
  final parts = address.split(',');
  return parts.isNotEmpty ? parts.last.trim() : '';
}

String _calculateTravelTime(String start, String end) {
  final startTime = _safeParseDateTime(start);
  final endTime = _safeParseDateTime(end);
  final diff = endTime.difference(startTime);
  final hours = diff.inHours.abs();
  final minutes = diff.inMinutes.abs() % 60;
  if (hours == 0) return '${minutes}m';
  if (minutes == 0) return '${hours}h';
  return '${hours}h ${minutes}min';
}

List<String> _calculateTimeToGo(String start) {
  final now = DateTime.now();
  final startTime = _safeParseDateTime(start);
  final boardingEnd = startTime.subtract(const Duration(minutes: 15));
  if (now.isBefore(boardingEnd)) {
    final diff = startTime.difference(now);
    final h = diff.inHours;
    final m = diff.inMinutes % 60;
    return h > 0 ? [h.toString(), "h"] : [m.toString(), "min"];
  } else if (now.isBefore(startTime)) {
    return ["Abordando", ""];
  } else {
    return ["Salió", ""];
  }
}

String _formatTime(String dtStr) =>
    DateFormat('HH:mm').format(_safeParseDateTime(dtStr));

String _formatDateTime(String dtStr) =>
    DateFormat('dd/MM/yyyy HH:mm').format(_safeParseDateTime(dtStr));

DateTime _safeParseDateTime(String input) {
  try {
    return DateTime.parse(input);
  } catch (_) {
    final now = DateTime.now();
    final parts = input.split(':');
    return DateTime(
        now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
  }
}
