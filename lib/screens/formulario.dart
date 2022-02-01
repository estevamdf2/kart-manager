import 'package:flutter/material.dart';
import 'package:kart_manager/database/dao/piloto_dao.dart';
import 'package:kart_manager/models/piloto.dart';
import 'package:kart_manager/components/editor.dart';

class FormularioPilotos extends StatelessWidget {
  final TextEditingController _controllerNomePiloto = TextEditingController();
  final TextEditingController _controllerNomeUniforme = TextEditingController();
  final TextEditingController _controllerCategoria = TextEditingController();
  BuildContext? context = null;
  final PilotoDao _dao = PilotoDao();

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
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                child: Text('Salvar'),
                onPressed: () {
                  _salvarPiloto();
                },
              ),
            ),
          )
        ]));
  }

  void _salvarPiloto() {
    final String? nomePiloto = _controllerNomePiloto.text;
    final String? nomeUniforme = _controllerNomeUniforme.text;
    // final Categoria categoria = _controllerCategoria.toString() as Categoria;
    final pilotoCadastrado = Piloto(0, nomePiloto!, nomeUniforme!);

    _dao
        .save(pilotoCadastrado)
        .then((id) => Navigator.pop(context!, pilotoCadastrado));

    Scaffold.of(null!).showSnackBar(
        SnackBar(content: Text('Piloto cadastrado com sucesso.')));
  }
}
