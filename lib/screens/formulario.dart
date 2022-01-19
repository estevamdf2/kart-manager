import 'package:flutter/material.dart';
import 'package:kart_manager/models/enum_categoria.dart';
import 'package:kart_manager/models/piloto.dart';
import 'package:kart_manager/components/editor.dart';

class FormularioPilotos extends StatelessWidget {
  final TextEditingController _controllerNomePiloto = TextEditingController();
  final TextEditingController _controllerNomeUniforme = TextEditingController();
  final TextEditingController _controllerCategoria = TextEditingController();
  String dropdownValue = 'F1';
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
            controlador: _controllerCategoria,
            rotulo: 'Categoria',
            dica: 'F1',
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              (() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['F1', 'F2', 'F3']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ]));
  }

  void _salvarPiloto() {
    final String? nomePiloto = _controllerNomePiloto.text;
    final String? nomeUniforme = _controllerNomeUniforme.text;
    // final Categoria categoria = _controllerCategoria.toString() as Categoria;
    final pilotoCadastrado = Piloto(0, nomePiloto!, nomeUniforme!);

    Navigator.pop(context!, pilotoCadastrado);
    Scaffold.of(null!).showSnackBar(
        SnackBar(content: Text('Piloto cadastrado com sucesso.')));
  }
}
