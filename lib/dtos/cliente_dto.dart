class ClienteDto {
  String _id;
  String _cpf;
  String _telefone;
  String _nome;

  ClienteDto({
    String? id,
    required String cpf,
    required String telefone,
    required String nome,
  }) :_id = id ?? '',
      _cpf = cpf,
      _telefone = telefone,
      _nome = nome;

  //Setters
  set id(String id) => _id = id;  
  set cpf(String valor) => _cpf = valor;
  set telefone(String valor) => _telefone = valor;
  set nome(String valor) => _nome = valor;   
    
  //Getters
  String get id => _id;  
  String get cpf => _cpf;
  String get telefone => _telefone;
  String get nome => _nome;
    
  factory ClienteDto.fromJson(Map<String, dynamic> json) {
    return ClienteDto(
      id: json['id'],
      cpf: json['cpf'],
      telefone: json['telefone'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'cpf': _cpf,
      'telefone': _telefone,
      'nome': _nome,
    };
  }
}


