import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TripDetailsCard extends StatelessWidget {
  final String? arrival;
  final int? seats;
  final String? name;
  final String? origin;
  final String? price;
  final String? originImage;
  final String? destination;
  final String? destinationImage;
  final String? plate;
  final List<int>? reservedSeats;

  const TripDetailsCard({
    Key? key,
    this.arrival,
    this.seats,
    this.name,
    this.origin,
    this.price,
    this.originImage,
    this.destination,
    this.destinationImage,
    this.plate,
    this.reservedSeats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre del conductor
          Text(
            name ?? "Conductor desconocido",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),

          // Imágenes de origen y destino
          Row(
            children: [
              _buildImage(originImage),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Text(
                        origin ?? "Origen desconocido",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      Icon(Icons.arrow_downward, color: Colors.grey),
                      Text(
                        destination ?? "Destino desconocido",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              _buildImage(destinationImage),
            ],
          ),
          SizedBox(height: 12),

          // Detalles adicionales
          _buildInfoRow("Placa:", plate),
          // _buildInfoRow("Hora de llegada:", arrival),
          _buildInfoRow("Precio:", price != null ? "\$$price" : "No disponible"),
          // _buildInfoRow("Asientos disponibles:", seats != null ? "$seats" : "No especificado"),
          _buildInfoRow("Reservados:", reservedSeats != null ? "${reservedSeats!.length}" : "0"),
        ],
      ),
    );
  }

 Widget _buildImage(String? imageUrl) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8), // Borde redondeado
    child: CachedNetworkImage(
      imageUrl: imageUrl ?? "https://via.placeholder.com/50",
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: 50,
        height: 50,
        color: Colors.grey[300], // Color de fondo mientras carga
        child: Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        width: 50,
        height: 50,
        color: Colors.grey, // Color de fondo en caso de error
        child: Icon(Icons.error, size: 30, color: Colors.white),
      ),
    ),
  );
}


  Widget _buildInfoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Text(value ?? "No disponible"),
        ],
      ),
    );
  }
}
