import 'item_produto_dto.dart';

class TituloDtoOut {
  String _id;
  double _valor;
  bool _pago;
  bool _estoqueMovimentado;
  bool _aprovado;
  String _cpf;
  String _cnpj;
  String _nome;
  String _telefone;
  String _idTitular;
  String _idEmissor;
  String _dataEmissao;

  List<ItemProdutoDto> _produtos;

  TituloDtoOut({
    required String id,
    required double valor,
    required bool pago,
    required bool estoqueMovimentado,
    required bool aprovado,
    required String cpf,
    required String cnpj,
    required String nome,
    required String? telefone,
    required String idTitular,
    required String idEmissor,
    required String dataEmissao,
    required List<ItemProdutoDto> produtos,
  })  : _id = id,
        _valor = valor,
        _pago = pago,
        _estoqueMovimentado = estoqueMovimentado,
        _aprovado = aprovado,
        _cpf = cpf,
        _cnpj = cnpj,
        _nome = nome,
        _telefone = telefone ?? '',
        _idTitular = idTitular,
        _idEmissor = idEmissor,
        _dataEmissao = dataEmissao,
        _produtos = produtos;

  String get id => _id;
  double get valor => _valor;
  bool get pago => _pago;
  bool get estoqueMovimentado => _estoqueMovimentado;
  bool get aprovado => _aprovado;
  String get cpf => _cpf;
  String get cnpj => _cnpj;
  String get nome => _nome;
  String get telefone => _telefone;
  String get idTitular => _idTitular;
  String get idEmissor => _idEmissor;
  String get dataEmissao => _dataEmissao;
  List<ItemProdutoDto> get produtos => _produtos;

  set id(String valor) => _id = valor;
  set valor(double v) => _valor = v;
  set pago(bool v) => _pago = v;
  set estoqueMovimentado(bool v) => _estoqueMovimentado = v;
  set aprovado(bool v) => _aprovado = v;
  set cpf(String v) => _cpf = v;
  set cnpj(String v) => _cnpj = v;
  set nome(String v) => _nome = v;
  set telefone(String v) => _telefone = v;
  set idTitular(String v) => _idTitular = v;
  set idEmissor(String v) => _idEmissor = v;
  set dataEmissao(String v) => _dataEmissao = v;
  set produtos(List<ItemProdutoDto> valor) => _produtos = valor;

  factory TituloDtoOut.fromJson(Map<String, dynamic> json) {
    return TituloDtoOut(
      id: json['id'],
      valor: json['valor'],
      pago: json['pago'],
      estoqueMovimentado: json['estoqueMovimentado'],
      aprovado: json['aprovado'],
      cpf: json['cpf'],
      cnpj: json['cnpj'],
      nome: json['nome'],
      telefone: json['telefone'],
      idTitular: json['idTitular'],
      idEmissor: json['idEmissor'],
      dataEmissao: json['dataEmissao'],
      produtos: (json['produtos'] as List<dynamic>)
          .map((item) => ItemProdutoDto.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'valor': _valor,
      'pago': _pago,
      'estoqueMovimentado': _estoqueMovimentado,
      'aprovado': _aprovado,
      'cpf': _cpf,
      'cnpj': _cnpj,
      'nome': _nome,
      'telefone': _telefone,
      'idTitular': _idTitular,
      'idEmissor': _idEmissor,
      'dataEmissao': _dataEmissao,
      'produtos': _produtos.map((p) => p.toJson()).toList(),
    };
  }
}
