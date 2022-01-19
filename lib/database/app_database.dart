import 'package:kart_manager/models/piloto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'kartmanager.db');
    return openDatabase(path, onCreate: (db, version) {
      final String sql = 'CREATE TABLE piloto(' +
          'id INTEGER PRIMARY KEY, ' +
          'nome_piloto TEXT, ' +
          'nome_uniforme TEXT)';
      db.execute(sql);
    }, version: 1);
  });
}

Future<int> save(Piloto piloto) {
  return createDatabase().then((db) {
    final Map<String, dynamic> pilotoMap = Map();
    pilotoMap['id'] = piloto.id;
    pilotoMap['nome_piloto'] = piloto.nomePiloto;
    pilotoMap['nome_uniforme'] = piloto.nomeUniforme;
    return db.insert('piloto', pilotoMap);
  });
}

Future<List<Piloto>> findAll() {
  return createDatabase().then((db) {
    return db.query('piloto').then((maps) {
      final List<Piloto> pilotos = List.empty(growable: false);
      for (Map<String, dynamic> map in maps) {
        final Piloto piloto =
            Piloto(map['id'], map['nome_piloto'], map['nome_uniforme']);
        pilotos.add(piloto);
      }

      return pilotos;
    });
  });
}
