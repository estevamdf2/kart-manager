import 'package:flutter/material.dart';

void main() {
  runApp(KartManager());
}

class KartManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: ListaPilotos()));
  }
}

class FormularioPilotos extends StatelessWidget {
  final TextEditingController _controllerNomePiloto = TextEditingController();
  final TextEditingController _controllerNomeUniforme = TextEditingController();
  final TextEditingController _controllerPontuacao = TextEditingController();
  BuildContext? context = null;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro pilotos'),
        ),
        body: Column(children: <Widget>[
          Editor(
              controlador: _controllerNomePiloto,
              rotulo: 'Nome piloto',
              dica: 'Nome completo piloto'),
          Editor(
              controlador: _controllerNomeUniforme,
              rotulo: 'Nome do uniforme',
              dica: 'Nome a ser impresso uniforme'),
          Editor(
            controlador: _controllerPontuacao,
            rotulo: 'Pontuação',
            dica: '30',
          ),
          ElevatedButton(
              child: Text('Cadastrar'), onPressed: () => _salvarPiloto()),
        ]));
  }

  void _salvarPiloto() {
    final String? nomePiloto = _controllerNomePiloto.text;
    final String? nomeUniforme = _controllerNomeUniforme.text;
    final double? pontuacao = double.tryParse(_controllerPontuacao.text);
    final pilotoCadastrado = Piloto(nomePiloto!, nomeUniforme!, pontuacao!);

    Navigator.pop(context!, pilotoCadastrado);
    Scaffold.of(null!).showSnackBar(
        SnackBar(content: Text('Piloto cadastrado com sucesso.')));
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
      ),
    );
  }
}

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
      appBar: AppBar(title: Text('Campeonato pilotos')),
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
            subtitle: Text(_piloto.pontuacao.toString())));
  }
}

class Piloto {
  final String nomePiloto;
  final String nomeUniforme;
  final double pontuacao;

  Piloto(this.nomePiloto, this.nomeUniforme, this.pontuacao);
}
