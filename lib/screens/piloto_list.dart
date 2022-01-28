import 'package:flutter/material.dart';
import 'package:kart_manager/database/app_database.dart';
import 'package:kart_manager/models/piloto.dart';
import 'package:kart_manager/screens/formulario.dart';

class PilotosList extends StatefulWidget {
  @override
  _PilotosListState createState() => _PilotosListState();
}

class _PilotosListState extends State<PilotosList> {
  final List<Piloto> pilotos = [];

  @override
  Widget build(BuildContext context) {
    pilotos.add(Piloto(0, 'Marcos', 'M.Sousa'));
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilotos'),
      ),
      body: FutureBuilder(
        future: findAll(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final Piloto piloto = pilotos[index];
              return _PilotoItem(piloto);
            },
            itemCount: pilotos.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (context) => FormularioPilotos()),
              )
              .then((newPiloto) => debugPrint(newPiloto.toString()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _PilotoItem extends StatelessWidget {
  final Piloto piloto;

  _PilotoItem(this.piloto);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(piloto.nomePiloto, style: TextStyle(fontSize: 24.0)),
      subtitle: Text(piloto.nomeUniforme, style: TextStyle(fontSize: 16.0)),
    ));
  }
}
