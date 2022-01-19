import 'package:flutter/material.dart';
import 'package:kart_manager/models/piloto.dart';
import 'package:kart_manager/screens/formulario.dart';

class ListaPilotos extends StatefulWidget {
  final List<Piloto> _pilotos = List.empty(growable: true);

  @override
  State<StatefulWidget> createState() {
    return ListaPilotosState();
  }
}

class ListaPilotosState extends State<ListaPilotos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro pilotos')),
      body: ListView.builder(
        itemCount: widget._pilotos.length,
        itemBuilder: (context, indice) {
          final piloto = widget._pilotos[indice];
          return ItemPiloto(piloto);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Piloto?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioPilotos();
          }));

          future.then((pilotoCadastrado) {
            Future.delayed(Duration(seconds: 1), () {
              debugPrint('chegou no then');
              if (pilotoCadastrado != null) {
                setState(() {
                  widget._pilotos.add(pilotoCadastrado);
                });
              }
            });
          });
        },
      ),
    );
  }
}

class ItemPiloto extends StatelessWidget {
  final Piloto _piloto;

  ItemPiloto(this._piloto);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: Icon(Icons.person),
            title: Text(_piloto.nomePiloto),
            subtitle: Text(_piloto.nomeUniforme.toString())));
  }
}
