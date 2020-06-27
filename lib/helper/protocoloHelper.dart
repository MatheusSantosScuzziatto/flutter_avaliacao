import 'package:flutter_avaliacao/model/protocolo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProtocoloHelper {
  static final String nomeTabela = "protocolo";
  static final ProtocoloHelper _protocoloHelper = ProtocoloHelper._internal();
  Database _db;

  factory ProtocoloHelper() {
    return _protocoloHelper;
  }

  ProtocoloHelper._internal() {}

  get db async{
    if (_db != null) {
      return _db;
    }
    _db = await inicializarDB();
    return _db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $nomeTabela(id INTEGER PRIMARY KEY AUTOINCREMENT, descricao VARCHAR, "
        "buraco INTEGER, calcada INTEGER, lotebaldio INTEGER, sinalizacao INTEGER, outros INTEGER, "
        "data VARCHAR, cep VARCHAR, endereco VARCHAR)");
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "protocolo.db");
    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarProtocolo(Protocolo protocolo) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, protocolo.toMap());
    return resultado;
  }

  listProtocolos() async {
    var bandoDados = await db;
    List protocolos = await bandoDados.rawQuery("SELECT * FROM $nomeTabela ORDER BY id ASC");
    return protocolos;
  }
}