import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BD {
  static Future<Database> openBD() async {
    return openDatabase(join(await getDatabasesPath(), 'bdpets'),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE pets (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, edad INTEGER, fecvac TEXT, raza TEXT, descri TEXT)");
        }, version: 1);
  }
}