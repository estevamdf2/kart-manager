import 'package:kart_manager/models/enum_categoria.dart';

class Piloto {
  final int id;
  final String nomePiloto;
  final String nomeUniforme;

  Piloto(this.id, this.nomePiloto, this.nomeUniforme);

  String toString() {
    return 'Piloto{id: $id, nome: $nomePiloto, nomeUniforme: $nomeUniforme}';
  }
}
