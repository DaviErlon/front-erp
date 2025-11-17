class ItemProdutoDto {
  String _produtoId;
  int _quantidade;

  ItemProdutoDto({
    required String produtoId,
    required int quantidade,
  })  : _produtoId = produtoId,
        _quantidade = quantidade;

  // Setters
  set produtoId(String valor) => _produtoId = valor;
  set quantidade(int valor) => _quantidade = valor;

  // Getters
  String get produtoId => _produtoId;
  int get quantidade => _quantidade;

  factory ItemProdutoDto.fromJson(Map<String, dynamic> json) {
    return ItemProdutoDto(
      produtoId: json['produto_id'],
      quantidade: json['quantidade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'produto_id': _produtoId,
      'quantidade': _quantidade,
    };
  }
}
