import 'package:flutter/material.dart';
import 'cadastroProtocolo.dart';
import 'consultaProtocolo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void _registrarProtocolo() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CadastroProtocolo()));
  }

  void _consultarProtocolo() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ConsultaProtocolo()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Protocolos"),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: _registrarProtocolo,
                  child: Image.asset("imagens/plus.png"),
                ),
                GestureDetector(
                  onTap: _consultarProtocolo,
                  child: Image.asset("imagens/magnifying-glass.png"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
