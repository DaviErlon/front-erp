class CadastroFuncionarioDto {
  
  String _email;
  String _senha;
  String _tipo;


  CadastroFuncionarioDto({
    required String email,
    required String senha,
    required String tipo,
  }) :_email = email,
      _senha = senha,
      _tipo = tipo;
     
    //Setters
    
    set email(String valor) => _email = valor;
    set senha(String valor) => _senha = valor;
    set tipo(String valor) => _tipo = valor;
    
    
    //Getters
    
    String get email => _email;
    String get senha => _senha;
    String get tipo => _tipo;
    
  factory CadastroFuncionarioDto.fromJson(Map<String, dynamic> json) {
    return CadastroFuncionarioDto(
      email: json['email'],
      senha: json['senha'],
      tipo: json['tipo'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'email': _email,
      'senha': _senha,
      'tipo': _tipo,
    };
  }
}


