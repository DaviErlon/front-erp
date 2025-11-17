class ProdutoDto {
  String _nome;
  double _preco;
  int _quantidade;

  ProdutoDto({
    required String nome,
    required double preco,
    required int quantidade,
  })  : _nome = nome,
        _preco = preco,
        _quantidade = quantidade;

  // Getters
  String get nome => _nome;
  double get preco => _preco;
  int get quantidade => _quantidade;

  // Setters
  set nome(String valor) => _nome = valor;
  set preco(double valor) => _preco = valor;
  set quantidade(int valor) => _quantidade = valor;

  factory ProdutoDto.fromJson(Map<String, dynamic> json) {
    return ProdutoDto(
      nome: json['nome'],
      preco: json['preco'].toDouble(),
      quantidade: json['quantidade'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'preco': _preco,
      'quantidade': _quantidade,
    };
  }
}
