import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'helper/protocoloHelper.dart';
import 'model/protocolo.dart';

class CadastroProtocolo extends StatefulWidget {
  @override
  _CadastroProtocoloState createState() => _CadastroProtocoloState();
}

class _CadastroProtocoloState extends State<CadastroProtocolo> {
  var _db = ProtocoloHelper();
  TextEditingController _data = new TextEditingController();
  TextEditingController _cep = new TextEditingController();
  TextEditingController _descricao = new TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _buraco = false;
  bool _lote = false;
  bool _sinalizacao = false;
  bool _calcada = false;
  bool _outros = false;
  String _resultadoCep = "";
  String _logradouro = "";
  String _complemento = "";
  String _bairro = "";
  String _localidade = "";
  String _uf = "";

  void _limparCampos() {
    _buraco = false;
    _lote = false;
    _sinalizacao = false;
    _calcada = false;
    _outros = false;
    _resultadoCep = "";
    _logradouro = "";
    _complemento = "";
    _bairro = "";
    _localidade = "";
    _uf = "";
    _data.text = "";
    _cep.text = "";
    _descricao.text = "";
    setState(() {
      _resultadoCep = "";
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2900));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        String dia = _selectedDate.day.toString();
        String mes = _selectedDate.month.toString();
        String ano = _selectedDate.year.toString();
        _data.text = "$dia/$mes/$ano";
      });
  }

  _recuperarCep() async {
    String cep = _cep.text;
    String url = "https://viacep.com.br/ws/$cep/json/";
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    _logradouro = retorno["logradouro"];
    _complemento = retorno["complemento"];
    _bairro = retorno["bairro"];
    _localidade = retorno["localidade"];
    _uf = retorno["uf"];

    setState(() {
      _resultadoCep = "${_logradouro}, ${_complemento}, ${_bairro}, ${_localidade} - ${_uf}";
    });
  }

  _salvar() async {
    String data = "${_data.text} ${TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute.toString()}";
    String cep = _cep.text;
    String endereco = _resultadoCep;
    String descricao = _descricao.text;
    bool buraco = _buraco;
    bool calcada = _calcada;
    bool lote = _lote;
    bool sinalizacao = _sinalizacao;
    bool outros = _outros;

    Protocolo protocolo = new Protocolo(
        descricao,
        (buraco) ? 1 : 0,
        (calcada) ? 1 : 0,
        (lote) ? 1 : 0,
        (sinalizacao) ? 1 : 0,
        (outros) ? 1 : 0,
        data, cep, endereco);
    int result = await _db.salvarProtocolo(protocolo);
    print("Protocolo Salvo: " + result.toString());
    _limparCampos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cadastro de Protocolos"),
      ),

      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Text("Caso", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              //region Caso
              CheckboxListTile(
                  title: Text("Buraco"),
                  activeColor: Colors.blue,
                  secondary: Icon(Icons.add_box),
                  value: _buraco,
                  onChanged: (bool valor) {
                    setState(() {
                      _buraco = valor;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Lote Baldio"),
                  activeColor: Colors.blue,
                  secondary: Icon(Icons.add_box),
                  value: _lote,
                  onChanged: (bool valor) {
                    setState(() {
                      _lote = valor;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Sinalizacao"),
                  activeColor: Colors.blue,
                  secondary: Icon(Icons.add_box),
                  value: _sinalizacao,
                  onChanged: (bool valor) {
                    setState(() {
                      _sinalizacao = valor;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Calçada"),
                  activeColor: Colors.blue,
                  secondary: Icon(Icons.add_box),
                  value: _calcada,
                  onChanged: (bool valor) {
                    setState(() {
                      _calcada = valor;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Outros"),
                  activeColor: Colors.blue,
                  secondary: Icon(Icons.add_box),
                  value: _outros,
                  onChanged: (bool valor) {
                    setState(() {
                      _outros = valor;
                    });
                  }),
              //endregion

              Padding(
                padding: EdgeInsets.all(20),
                child: Text("Data e Local", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              //region Data e Local
              Row(
                children: <Widget>[
                  Expanded(child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Data"),
                    style: TextStyle(fontSize: 15),
                    maxLength: 200,
                    enabled: false,
                    controller: _data,
                  ),),
                  IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "CEP"),
                    style: TextStyle(fontSize: 15),
                    maxLength: 200,
                    controller: _cep,
                  ),),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => _recuperarCep(),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent)
                ),
                child: Text(_resultadoCep, textAlign: TextAlign.center, ),
              ),
              //endregion

              Padding(
                padding: EdgeInsets.all(20),
                child: Text("Descrição", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              //region Descrição
              TextField(
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 15),
                maxLength: 1000,
                maxLines: 5,
                controller: _descricao,
              ),
              //endregion

              RaisedButton(
                padding: EdgeInsets.all(20),
                onPressed: _salvar,
                color: Colors.blue,
                child: Text("Registrar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
