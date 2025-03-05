
import 'package:BusGo/models/ticket/ticket_dabase_local/ticket_dabase_local_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class DatabaseHelper {
  static Database? _database;

  // Inicializa la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Abre o crea la base de datos
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tickets.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Crear las tablas
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tickets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        branchId INTEGER,
        tripId INTEGER,
        method TEXT,
        status INTEGER,
        quantity INTEGER,
        price REAL,
        seats TEXT,
        date TEXT,
        adults INTEGER,
        minors INTEGER,
        total REAL,
        transactionStatus TEXT,
        sequenceNumber TEXT,
        extraData TEXT,
        transactionTip REAL,
        transactionCashback REAL
      )
    ''');
  }

  // Insertar un ticket con manejo de errores
Future<int?> insertTicket(Ticket ticket) async {
  try {
    Database db = await database;
    int id = await db.insert('tickets', ticket.toMap());
    print('Ticket insertado con éxito, ID: $id');
    return id; // Retorna el ID del ticket insertado
  } catch (e) {
    print('Error al insertar el ticket: $e');
    return null; // Retorna null si la inserción falla
  }
}


  // Obtener todos los tickets
  Future<List<Ticket>> getTickets() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tickets');

    return List.generate(maps.length, (i) {
      return Ticket.fromMap(maps[i]);
    });
  }

  Future<int> getTicketCount() async {
  Database db = await database;
  final List<Map<String, dynamic>> result = await db.rawQuery('SELECT COUNT(*) AS count FROM tickets');
  return Sqflite.firstIntValue(result) ?? 0;
}


  // Eliminar un ticket por ID
  Future<int> deleteTicket(int id) async {
    Database db = await database;
    return await db.delete('tickets', where: 'id = ?', whereArgs: [id]);
  }
}
