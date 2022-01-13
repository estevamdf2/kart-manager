import 'package:flutter/material.dart';
import 'package:kart_manager/models/piloto.dart';
import 'package:kart_manager/components/editor.dart';

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
