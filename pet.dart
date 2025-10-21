class Pet {
  int? id;
  String nombre;
  int edad;
  String fecvac;
  String raza;
  String descri;
  Pet(this.id, this.nombre, this.edad, this.fecvac, this.raza, this.descri);
  Map <String, dynamic> toMap(){
    return (
      {
        'nombre':nombre,
        'edad':edad,
        'fecvac':fecvac,
        'raza': raza,
        'descri': descri
      }
    );
  }
  fromMap(Map<dynamic, dynamic> map) {
    id = int.parse(map['id']);
    nombre = map['nombre'];
    edad = int.parse(map['edad']);
    fecvac = map['fecvac'];
    raza = map['raza'];
    descri = map['descri'];
  }

  @override
  String toString() {
    return 'Pet{id: $id, nombre: $nombre, edad: $edad, fecvac: $fecvac, raza: $raza, descri: $descri}';
  }
}
