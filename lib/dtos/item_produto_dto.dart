class ItemProdutoDto {
  String _id;
  double _valor;
  String _produtoId;
  int _quantidade;

  ItemProdutoDto({
    String id = '',
    double valor = 0.0,
    required String produtoId,
    required int quantidade,
  })  : _id = id,
        _valor = valor,
        _produtoId = produtoId,
        _quantidade = quantidade;

  // Setters
  set produtoId(String valor) => _produtoId = valor;
  set quantidade(int valor) => _quantidade = valor;
  set id(String valor) => _id = valor;
  set valor(double valor) => _valor = valor;

  // Getters
  String get produtoId => _produtoId;
  int get quantidade => _quantidade;
  double get valor => _valor;
  String get id => _id;

  factory ItemProdutoDto.fromJson(Map<String, dynamic> json) {
    return ItemProdutoDto(
      produtoId: json['id'],
      quantidade: json['quantidade'],
      id: json['id'],
      valor: json['valor']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'produtoId': _produtoId,
      'quantidade': _quantidade,
    };
  }
}
