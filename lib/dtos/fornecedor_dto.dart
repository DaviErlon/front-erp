class FornecedorDto {
  String _id;
  String _cpf;
  String _cnpj;
  String _telefone;
  String _nome;

  FornecedorDto({
    String id = '',
    String cpf = '',
    String cnpj = '',
    required String telefone,
    required String nome,
  }) :_id = id,
      _cpf = cpf,
      _cnpj = cnpj,
      _telefone = telefone,
      _nome = nome;

    //Setters
  set id(String id) => _id = id;
  set cpf(String valor) => _cpf = valor;
  set cnpj(String valor) => _cnpj = valor;
  set telefone(String valor) => _telefone = valor;
  set nome(String valor) => _nome = valor;
    
    
    //Getters
  String get id => _id;
  String get cpf => _cpf;
  String get cnpj => _cnpj;
  String get telefone => _telefone;
  String get nome => _nome;
    
  factory FornecedorDto.fromJson(Map<String, dynamic> json) {
    return FornecedorDto(
      cpf: json['cpf'] ?? '',
      cnpj: json['cnpj'] ?? '',
      telefone: json['telefone'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      if(_cpf.isNotEmpty) 'cpf': _cpf,
      if(_cnpj.isNotEmpty) 'cnpj': _cnpj,
      'telefone': _telefone,
      'nome': _nome,
    };
  }
}


