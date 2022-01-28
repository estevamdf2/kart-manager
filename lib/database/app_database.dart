import 'package:kart_manager/models/piloto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'kartmanager.db');
  return openDatabase(path, onCreate: (db, version) {
    final String sql = 'CREATE TABLE piloto(' +
        'id INTEGER PRIMARY KEY, ' +
        'nome_piloto TEXT, ' +
        'nome_uniforme TEXT)';
    db.execute(sql);
  }, version: 1);
  // onDowngrade: onDatabaseDowngradeDelete);
}

Future<int> save(Piloto piloto) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> pilotoMap = Map();
  pilotoMap['nome_piloto'] = piloto.nomePiloto;
  pilotoMap['nome_uniforme'] = piloto.nomeUniforme;
  return db.insert('piloto', pilotoMap);
}

Future<List<Piloto>> findAll() async {
  final Database db = await getDatabase();
  final List<Map<String, Object?>> result = await db.query('piloto');
  final List<Piloto> pilotos = [];
  for (Map<String, dynamic> row in result) {
    final Piloto piloto =
        Piloto(row['id'], row['nome_piloto'], row['nome_uniforme']);
    pilotos.add(piloto);
  }
  return pilotos;
}
