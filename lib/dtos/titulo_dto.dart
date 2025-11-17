import 'item_produto_dto.dart';

class TituloDto {
  String _id;
  List<ItemProdutoDto> _produtos;

  TituloDto({
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


  factory TituloDto.fromJson(Map<String, dynamic> json) {
    return TituloDto(
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
