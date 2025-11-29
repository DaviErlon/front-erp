import 'package:fronterp/dtos/funcionario_dto.dart';
import 'package:fronterp/dtos/item_produto_dto.dart';

class TituloDto {
  String _id;
  double _valor;
  bool _pago;
  bool _estoqueMovimentado;
  bool _aprovado;
  String _cpf;
  String _cnpj;
  String _nome;
  String _telefone;
  FuncionarioDto? _emissor;
  String _dataEmissao;
  List<ItemProdutoDto> _produtos;

  TituloDto({
    required String id,
    required double valor,
    required bool pago,
    required bool estoqueMovimentado,
    required bool aprovado,
    String cpf = '',
    String cnpj = '',
    required String nome,
    String telefone = '',
    FuncionarioDto? emissor,
    required String dataEmissao,
    required List<ItemProdutoDto> produtos,
  }) : _id = id,
       _valor = valor,
       _pago = pago,
       _estoqueMovimentado = estoqueMovimentado,
       _aprovado = aprovado,
       _cpf = cpf,
       _cnpj = cnpj,
       _nome = nome,
       _telefone = telefone,
       _emissor = emissor,
       _dataEmissao = dataEmissao,
       _produtos = produtos;

  // Getters...
  String get id => _id;
  double get valor => _valor;
  bool get pago => _pago;
  bool get estoqueMovimentado => _estoqueMovimentado;
  bool get aprovado => _aprovado;
  String get cpf => _cpf;
  String get cnpj => _cnpj;
  String get nome => _nome;
  String get telefone => _telefone;
  FuncionarioDto? get emissor => _emissor;
  String get dataEmissao => _formatarDataOffset(_dataEmissao);
  List<ItemProdutoDto> get produtos => _produtos;

  // Setters...
  set id(String valor) => _id = valor;
  set valor(double v) => _valor = v;
  set pago(bool v) => _pago = v;
  set estoqueMovimentado(bool v) => _estoqueMovimentado = v;
  set aprovado(bool v) => _aprovado = v;
  set cpf(String v) => _cpf = v;
  set cnpj(String v) => _cnpj = v;
  set nome(String v) => _nome = v;
  set telefone(String v) => _telefone = v;
  set emissor(FuncionarioDto v) => _emissor = v;
  set dataEmissao(String v) => _dataEmissao = v;
  set produtos(List<ItemProdutoDto> valor) => _produtos = valor;

  factory TituloDto.fromJson(Map<String, dynamic> json) {
    return TituloDto(
      id: json['id'] as String? ?? '',
      valor: (json['valor'] as num?)?.toDouble() ?? 0.0,
      pago: json['pago'] as bool? ?? false,
      estoqueMovimentado: json['estoqueMovimentado'] as bool? ?? false,
      aprovado: json['aprovado'] as bool? ?? false,
      cpf: json['cpf'] ?? '',
      cnpj: json['cnpj'] ?? '',
      nome: json['nome'] ?? 'Sem nome',
      telefone: json['telefone'] ?? '',
      emissor: FuncionarioDto.fromJson(json['emissor'] as Map<String, dynamic>),
      dataEmissao: json['criadoEm'] as String? ?? '',
      produtos:
          (json['produtosDosTitulos'] as List<dynamic>? ?? [])
              .map(
                (item) => ItemProdutoDto.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }

  static String _formatarDataOffset(String offsetDateTimeString) {
    final dateTime = DateTime.parse(offsetDateTimeString).toUtc();

    String dois(int n) => n.toString().padLeft(2, '0');

    final dia = dois(dateTime.day);
    final mes = dois(dateTime.month);
    final ano = dateTime.year.toString();

    final hora = dois(dateTime.hour);
    final minuto = dois(dateTime.minute);

    return "$dia/$mes/$ano $hora:$minuto";
  }
}
