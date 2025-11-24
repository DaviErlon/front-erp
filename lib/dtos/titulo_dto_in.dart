import 'item_produto_dto.dart';

class TituloDtoIn {
  String _id;
  List<ItemProdutoDto> _produtos;

  TituloDtoIn({
    required String id,
    required List<ItemProdutoDto> produtos,
  })  : _id = id,
        _produtos = produtos;

  // Getters
  String get id => _id;
  List<ItemProdutoDto> get produtos => _produtos;

  // Setters
  set id(String valor) => _id = valor;
  set produtos(List<ItemProdutoDto> valor) => _produtos = valor;


  factory TituloDtoIn.fromJson(Map<String, dynamic> json) {
    return TituloDtoIn(
      id: json['id'],
      produtos: (json['produtos'] as List<dynamic>)
          .map((item) => ItemProdutoDto.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'produtos': _produtos.map((p) => p.toJson()).toList(),
    };
  }
}
