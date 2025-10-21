import 'package:vam_actividad03/dao.dart';
import 'package:vam_actividad03/modelo/pet.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}
List <Pet> _pets = [];
class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context)=>ventanaInicio(),
        '/agregar':(context)=>ventanaAgregar(),
        '/editar':(context)=>ventanaEditar(),
        '/detalle':(context)=>ventanaDetalle(),

      },
    );
  }
}

class ventanaInicio extends StatefulWidget {
  const ventanaInicio({super.key});

  @override
  State<ventanaInicio> createState() => _ventanaInicioState();
}

class _ventanaInicioState extends State<ventanaInicio> {
  List _listaPets = [{'nombre': 'Elvis', 'raza': 'Mestizo'}, {'nombre':'Sultan','raza':'Pastor'}];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Listado de mascotas'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: _pets.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(_pets[index].nombre),
              subtitle: Text(_pets[index].raza),
              leading: IconButton(
                  onPressed: (){
                      int? id = _pets[index].id;
                      _mostrarDialogo(context, id!);
                  },
                  icon: Icon(Icons.delete_outline_outlined)
              ),
              trailing: IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/editar",
                        arguments: {'id':_pets[index].id,'nombre':_pets[index].nombre,'edad':_pets[index].edad, 'fecvac':_pets[index].fecvac, 'raza':_pets[index].raza, 'descri':_pets[index].descri});
                  },
                  icon: Icon(Icons.edit),
              ),
              onTap: (){
                Navigator.pushNamed(context, "/detalle",
                    arguments: {'id':_pets[index].id,'nombre':_pets[index].nombre,'edad':_pets[index].edad, 'fecvac':_pets[index].fecvac, 'raza':_pets[index].raza, 'descri':_pets[index].descri});
              },
            );
          }
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
             Navigator.pushNamed(context, "/agregar");
          },
          backgroundColor: Colors.green,
          tooltip: 'Agregar registro',
          child: Icon(Icons.add, size: 30,),
      ),

    );
  }

  @override
  void initState() {
    _refrescarLista();
  }
  void _refrescarLista() async {
    List <Pet> lista = await obtenerPets();
    print (lista);
    setState(() {
      _pets=lista;
    });
  }
}

class ventanaAgregar extends StatefulWidget {
  const ventanaAgregar({super.key});

  @override
  State<ventanaAgregar> createState() => _ventanaAgregarState();
}

class _ventanaAgregarState extends State<ventanaAgregar> {
  var controNom = TextEditingController();
  var controEdad = TextEditingController();
  var controFecvac = TextEditingController();
  var controRaza = TextEditingController();
  var controDescri = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Agregar registro'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Introduce los sigs datos:'),
            Divider(height: 10, color: Colors.blue,),
            Padding(padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: controNom,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Introduce nombre',
                  icon: Icon(Icons.pets_outlined),
                  iconColor: Colors.brown,
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: controEdad,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Introduce edad',
                  icon: Icon(Icons.numbers_outlined),
                  iconColor: Colors.blue,
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: controFecvac,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Introduce fecha vac (dd/mm/aa',
                  icon: Icon(Icons.date_range),
                  iconColor: Colors.blue,
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: controRaza,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Introduce raza',
                  icon: Icon(Icons.pets_sharp),
                  iconColor: Colors.brown,
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: controDescri,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Introduce nombre',
                  icon: Icon(Icons.description_outlined),
                  iconColor: Colors.blue,
                ),
              ),
            ),
            Divider(height: 10, color: Colors.blue,),
            ElevatedButton(
                onPressed: () async{
                  int? id;
                  String nom = controNom.text;
                  int edad= int.parse(controEdad.text);
                  String fecvac = controFecvac.text;
                  String raza = controRaza.text;
                  String descri= controDescri.text;
                  Pet pet1 = Pet(id, nom, edad, fecvac, raza, descri);
                  int reg = await agregarPet(pet1);
                  print ('Registro agregado: $reg');
                  Navigator.pushNamed(context, "/");
                },
                child: Text('Agregar registro')
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/");
                },
                child: Text('Cancelar')),
          ],
        ),
      ),
    );
  }
}

class ventanaEditar extends StatefulWidget {
  const ventanaEditar({super.key});

  @override
  State<ventanaEditar> createState() => _ventanaEditarState();
}

class _ventanaEditarState extends State<ventanaEditar> {
  @override
  Widget build(BuildContext context) {
    var registro = ModalRoute.of(context)!.settings.arguments as Map;
    var sId = registro['id'];
    var sNom = registro['nombre'];
    var sEdad = registro['edad'];
    var sFecvac = registro['fecvac'];
    var sRaza = registro['raza'];
    var sDescri = registro['descri'];
    var controId = TextEditingController();
    var controNom = TextEditingController();
    var controEdad = TextEditingController();
    var controFecvac = TextEditingController();
    var controRaza = TextEditingController();
    var controDescri = TextEditingController();
    controId.text = sId.toString();
    controNom.text = sNom;
    controEdad.text = sEdad.toString();
    controFecvac.text = sFecvac;
    controRaza.text = sRaza;
    controDescri.text = sDescri;
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar registro'),
      ),
      body: SingleChildScrollView(
      child:
      Center(
        child: Column(
          children: [
            Text('Editar los sigs datos:'),
            Padding(padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                controller: controId,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Id',
                  icon: Icon(Icons.numbers_outlined),
                  labelText: 'Id',
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              controller: controNom,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Introduce nombre',
                labelText: 'Nombre:',
                  icon: Icon(Icons.pets_sharp),
                iconColor: Colors.blue,
              ),
            ),
            ),
            
            Padding(padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                controller: controEdad,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Introduce edad',
                  labelText: 'Edad:',
                  icon: Icon(Icons.numbers_outlined),
                  iconColor: Colors.blue,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                controller: controFecvac,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Introduce Fecha Vac',
                  labelText: 'Fecha vac:',
                  icon: Icon(Icons.date_range),
                  iconColor: Colors.blue,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: controRaza,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Introduce raza',
                  labelText: 'raza:',
                  icon: Icon(Icons.pets_rounded),
                  iconColor: Colors.blue,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20, right: 15.0),
              child: TextFormField(
                controller: controDescri,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Introduce descripcion',
                  labelText: 'Descripcion:',
                  icon: Icon(Icons.description_rounded),
                  iconColor: Colors.blue,
                ),
              ),
            ),
            Divider(
              height: 10,
            ),
            ElevatedButton(
                onPressed:() async{
                  int id = int.parse(controId.text);
                  String nom = controNom.text;
                  int edad= int.parse(controEdad.text);
                  String fecvac = controFecvac.text;
                  String raza = controRaza.text;
                  String descri= controDescri.text;
                  Pet pet1 = Pet(id, nom, edad, fecvac, raza, descri);
                  int reg = await cambiarPet(pet1);
                  print ('registro actualizado: $reg');
                  Navigator.pushNamed(context, "/");

                },

                child: Text('Editar registro')
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/");
                },
                child: Text('Cancelar'),
            ),
          ],
        ),
      ),
      ),

    );


  }
}

class ventanaDetalle extends StatefulWidget {
  const ventanaDetalle({super.key});

  @override
  State<ventanaDetalle> createState() => _ventanaDetalleState();
}

class _ventanaDetalleState extends State<ventanaDetalle> {
  @override
  Widget build(BuildContext context) {
    var registro = ModalRoute.of(context)!.settings.arguments as Map;
    var sId = registro['id'];
    var sNom = registro['nombre'];
    var sEdad = registro['edad'];
    var sFecvac = registro['fecvac'];
    var sRaza = registro['raza'];
    var sDescri = registro['descri'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de registro'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Detalle de registro:'),
            Divider(height: 10, color: Colors.red,),
            Text('Id: ${sId}'),
            Divider(height: 10, color: Colors.blue,),
            Text('Nombre: ${sNom}'),
            Divider(height: 10, color: Colors.blue,),
            Text('Edad: ${sEdad}'),
            Divider(height: 10, color: Colors.blue,),
            Text('Fecha vac: ${sFecvac}'),
            Divider(height: 10, color: Colors.blue,),
            Text('Raza: ${sRaza}'),
            Divider(height: 10, color: Colors.blue,),
            Text('Descripcion: ${sDescri}'),
            Divider(height: 10, color: Colors.blue,),
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Regresar')
            ),
          ],
        ),
      ),
    );
  }
}



void _mostrarDialogo(BuildContext context, int Id){
  showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Borrar registro'),
          content: Text('Deseas borrar registro con Id: ${Id}'),
          actions: [
            ElevatedButton(
                onPressed: () async{
                  int reg = await borrarPet(Id);
                  print ('Registro borrado ${reg}');
                  Navigator.pushNamed(context, "/");
                },
                child: Text('SI')
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('NO')
            ),
          ],
        );
      }
  );
}



