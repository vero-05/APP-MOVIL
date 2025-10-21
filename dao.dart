
// funciones para manipular la base d e datos

import 'package:sqflite/sqflite.dart';

import 'bd/bd.dart';
import 'modelo/pet.dart';

Future<List<Pet>> obtenerPets() async {
  final db = await BD.openBD();
  final List<Map<String, dynamic>> maps = await db.query('pets');

  // print (maps);
  return List.generate(maps.length, (i) {
    return Pet(maps[i]['id'], maps[i]['nombre'], maps[i]['edad'],
        maps[i]['fecvac'], maps[i]['raza'], maps[i]['descri']);
  });
}

Future<int> agregarPet(Pet pet) async {
  Database db = await BD.openBD();
  return db.insert('pets', pet.toMap());
}

Future <int> cambiarPet(Pet pet) async{
  Database db = await BD.openBD();
  return db.update('pets', pet.toMap(), where: 'id=?', whereArgs: [pet.id] );
}

Future<int> borrarPet(int id) async{
  Database database = await BD.openBD();
  return database.delete('pets', where: 'id=?', whereArgs: [id]);
}
