class CadastroDto {
  
  String _nome;
  String _email;
  String _senha;
  String _cpf;
  String _plano;

  CadastroDto({
    required String nome,
    required String email,
    required String senha,
    required String cpf,
    required String plano,
  }) :_nome = nome,
      _email = email,
      _senha = senha,
      _cpf = cpf,
      _plano = plano;

    //Setters
    
    set nome(String valor) => _nome = valor;
    set email(String valor) => _email = valor;
    set senha(String valor) => _senha = valor;
    set cpf(String valor) => _cpf = valor;
    set plano(String valor) => _plano = valor;
    
    //Getters
    
    String get nome => _nome;
    String get email => _email;
    String get senha => _senha;
    String get cpf => _cpf;
    String get plano => _plano;

  factory CadastroDto.fromJson(Map<String, dynamic> json) {
    return CadastroDto(
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      cpf: json['cpf'],
      plano: json['plano'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'nome': _nome,
      'email': _email,
      'senha': _senha,
      'cpf': _cpf,
      'plano': _plano,
    };
  }
}