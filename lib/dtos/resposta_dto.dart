class RespostaDto {
  
  String _token;
  String _tipo;
  String _plano;
  String _nome;

  RespostaDto({
    required String token,
    required String tipo,
    required String plano,
    required String nome,
  }) :_token = token,
      _tipo = tipo,
      _plano = plano,
      _nome = nome;

    //Setters
    
    set token(String valor) => _token = valor;
    set tipo(String valor) => _tipo = valor;
    set plano(String valor) => _plano = valor;
    set nome(String valor) => _nome = valor;
    
    
    //Getters
    
    String get token => _token;
    String get tipo => _tipo;
    String get plano => _plano;
    String get nome => _nome;
    
  factory RespostaDto.fromJson(Map<String, dynamic> json) {
    return RespostaDto(
      token: json['token'],
      tipo: json['tipo'],
      plano: json['plano'],
      nome: json['nome'],
    );
  }
}


