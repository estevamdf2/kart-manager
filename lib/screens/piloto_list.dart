import 'package:flutter/material.dart';
import 'package:kart_manager/database/dao/piloto_dao.dart';
import 'package:kart_manager/models/piloto.dart';
import 'package:kart_manager/screens/formulario.dart';

class PilotosList extends StatefulWidget {
  @override
  _PilotosListState createState() => _PilotosListState();
}

class _PilotosListState extends State<PilotosList> {
  final PilotoDao _dao = PilotoDao();

//TODO refatorar este trecho
// https://github.com/alura-cursos/flutter-persistencia-interna/blob/crud/lib/screens/contacts_list.dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilotos'),
      ),
      body: FutureBuilder(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading ...')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final Object? result = snapshot.data;
              List<Piloto> pilotos = [];
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Piloto piloto = result![index];
                  return _PilotoItem(piloto);
                },
                itemCount: pilotos.length,
              );
              break;
          }
          return Text('Unknow error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (context) => FormularioPilotos()),
              )
              .then((newPiloto) => setState(() {}));
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
