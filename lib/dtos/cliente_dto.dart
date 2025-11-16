class ClienteDto {
  
  String _cpf;
  String _telefone;
  String _nome;

  ClienteDto({
    required String cpf,
    required String telefone,
    required String nome,
  }) :_cpf = cpf,
      _telefone = telefone,
      _nome = nome;

    //Setters
    
    set cpf(String valor) => _cpf = valor;
    set telefone(String valor) => _telefone = valor;
    set nome(String valor) => _nome = valor;
    
    
    //Getters
    
    String get cpf => _cpf;
    String get telefone => _telefone;
    String get nome => _nome;
    
  factory ClienteDto.fromJson(Map<String, dynamic> json) {
    return ClienteDto(
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


