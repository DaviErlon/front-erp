class RespostaDTO {
  
  final String token;
  final String tipo;
  final String plano;
  final String nome;

  RespostaDTO({
    required this.token,
    required this.tipo,
    required this.plano,
    required this.name,
  });
  factory RespostaDTO.fromJson(Map<String, dynamic> json) {
    return RespostaDTO(
      token: json['token'],
      tipo: json['tipo'],
      plano: json['plano'],
      nome: json['nome'],
    );
  }
}


