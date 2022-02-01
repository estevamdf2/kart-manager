import 'package:kart_manager/models/piloto.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class PilotoDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_nomePiloto TEXT, '
      '$_nomeUniforme TEXT)';

  static const String _tableName = 'pilotos';
  static const String _id = 'id';
  static const String _nomePiloto = 'nome_piloto';
  static const String _nomeUniforme = 'nome_uniforme';

  Future<int> save(Piloto piloto) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> pilotoMap = _toMap(piloto);
    return db.insert(_tableName, pilotoMap);
  }

  Future<List<Piloto>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, Object?>> result = await db.query(_tableName);
    List<Piloto> pilotos = _toList(result);
    return pilotos;
  }

  Future<int> update(Piloto piloto) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> pilotoMap = _toMap(piloto);
    return db.update(
      _tableName,
      pilotoMap,
      where: 'id = ?',
      whereArgs: [piloto.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Map<String, dynamic> _toMap(Piloto piloto) {
    final Map<String, dynamic> pilotoMap = Map();
    pilotoMap[_nomePiloto] = piloto.nomePiloto;
    pilotoMap[_nomeUniforme] = piloto.nomeUniforme;
    return pilotoMap;
  }

  List<Piloto> _toList(List<Map<String, dynamic>> result) {
    final List<Piloto> pilotos = [];
    for (Map<String, dynamic> row in result) {
      final Piloto piloto =
          Piloto(row[_id], row[_nomePiloto], row[_nomeUniforme]);
      pilotos.add(piloto);
    }
    return pilotos;
  }
}
