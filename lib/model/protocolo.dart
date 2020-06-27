class Protocolo {
  int id;
  String descricao;
  int buraco;
  int calcada;
  int lotebaldio;
  int sinalizacao;
  int outros;
  String data;
  String cep;
  String endereco;

  Protocolo(this.descricao, this.buraco, this.calcada, this.lotebaldio,
      this.sinalizacao, this.outros, this.data, this.cep, this.endereco);

  Protocolo.fromMap(Map map) {
    this.id = map["id"];
    this.descricao = map["descricao"];
    this.buraco = map["buraco"];
    this.calcada = map["calcada"];
    this.lotebaldio = map["lotebaldio"];
    this.sinalizacao = map["sinalizacao"];
    this.outros = map["outro"];
    this.data = map["data"];
    this.cep = map["cep"];
    this.endereco = map["endereco"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "descricao": this.descricao,
      "buraco": this.buraco,
      "calcada": this.calcada,
      "lotebaldio": this.lotebaldio,
      "sinalizacao": this.sinalizacao,
      "outros": this.outros,
      "data": this.data,
      "cep": this.cep,
      "endereco": this.endereco
    };

    if (this.id != null) {
      map["id"] = this.id;
    }
    return map;
  }
}