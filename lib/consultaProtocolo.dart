import 'package:flutter/material.dart';
import 'helper/protocoloHelper.dart';
import 'model/protocolo.dart';

class ConsultaProtocolo extends StatefulWidget {
  @override
  _ConsultaProtocoloState createState() => _ConsultaProtocoloState();
}

class _ConsultaProtocoloState extends State<ConsultaProtocolo> {
  List _itens = [];
  var _db = ProtocoloHelper();
  List<Protocolo> _protocolos = List<Protocolo>();

  @override
  void initState() {
    super.initState();
    _recuperarProtocolos();
  }

  _recuperarProtocolos() async {
    List protocolosRecuperados = await _db.listProtocolos();
    List<Protocolo> listaTemporaria = List<Protocolo>();
    for (var item in protocolosRecuperados) {
      Protocolo protocolo = Protocolo.fromMap(item);
      listaTemporaria.add(protocolo);
    }
    setState(() {
      _protocolos = listaTemporaria;
    });
    listaTemporaria = null;
    _carregarItens();
  }

  void _carregarItens() async {
    _itens = [];
    for(int i=0; i<=10; i++) {
      Map<String, dynamic> item = Map();
      item["id"] = "${_protocolos[i].id}";
      item["caso"] = "${_getCaso(_protocolos[i])}";
      item["endereco"] = "${_protocolos[i].endereco}";
      item["descricao"] = "${_protocolos[i].descricao}";
      item["data"] = "${_protocolos[i].data}";
      _itens.add(item);
    }
  }

  String _getCaso(Protocolo protocolo) {
    String ret = "";
    if(protocolo.buraco == 1) {
      ret += "Buraco. ";
    }
    if(protocolo.calcada == 1) {
      ret += "Calçada. ";
    }
    if(protocolo.lotebaldio == 1) {
      ret += "Lote Baldio. ";
    }
    if(protocolo.sinalizacao == 1) {
      ret += "Sinalização. ";
    }
    if(protocolo.outros == 1) {
      ret += "Outros. ";
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cadastro de Protocolos"),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (context, indice) {
              return ListTile (
                title: Text(_itens[indice]["id"]),
                subtitle: Text(
                    _itens[indice]["caso"] + _itens[indice]["endereco"]
                    +"\n"+ _itens[indice]["descricao"]
                    +"\n"+ _itens[indice]["data"]
                ),
              );
            }
        ),
      ),
    );
  }
}
