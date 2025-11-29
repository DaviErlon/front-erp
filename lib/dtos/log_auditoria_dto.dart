import 'package:fronterp/dtos/funcionario_dto.dart';

class LogAuditoriaDto {
  String _id;
  FuncionarioDto _emissor;
  String _nome;
  String _cpf;
  String _email;
  String _telefone;
  String _setor;
  String _acao;
  String _entidade;
  String _entidadeId;
  String _detalhes;
  String _data;
  DateTime? inicio;
  DateTime? fim;

  LogAuditoriaDto({
    String id = '',
    required FuncionarioDto emissor,
    required String nome,
    required String cpf,
    String email = '',
    required String telefone,
    String setor = '',
    required String acao,
    String entidade = '',
    String entidadeId = '',
    String detalhes = '',
    String data = '',
    this.inicio,
    this.fim,
  }) : _id = id,
       _emissor = emissor,
       _nome = nome,
       _cpf = cpf,
       _email = email,
       _telefone = telefone,
       _setor = setor,
       _acao = acao,
       _entidade = entidade,
       _entidadeId = entidadeId,
       _data = data,
       _detalhes = detalhes;

  String get id => _id;
  FuncionarioDto get emissor => _emissor;
  String get nome => _nome;
  String get cpf => _cpf;
  String get email => _email;
  String get telefone => _telefone;
  String get setor => _setor;
  String get acao => _acao;
  String get entidade => _entidade;
  String get entidadeId => _entidadeId;
  String get detalhes => _detalhes;
  String get data => _formatarDataOffset(_data);

  set id(String v) => _id = v;
  set idEmissor(FuncionarioDto v) => _emissor = v;
  set nome(String v) => _nome = v;
  set cpf(String v) => _cpf = v;
  set email(String v) => _email = v;
  set telefone(String v) => _telefone = v;
  set setor(String v) => _setor = v;
  set acao(String v) => _acao = v;
  set entidade(String v) => _entidade = v;
  set entidadeId(String v) => _entidadeId = v;
  set detalhes(String v) => _detalhes = v;

  factory LogAuditoriaDto.fromJson(Map<String, dynamic> json) {
    return LogAuditoriaDto(
      id: json['id'],
      emissor: FuncionarioDto.fromJson(json['funcionario']),
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      telefone: json['telefone'] ?? '',
      setor: json['setor'],
      acao: json['acao'],
      entidade: json['entidade'],
      entidadeId: json['entidadeId'],
      detalhes: json['detalhes'],
      data: json['criadoEm'],
    );
  }

  static String _formatarDataOffset(String offsetDateTimeString) {
  final localDate = DateTime.parse(offsetDateTimeString).toLocal();

  String dois(int n) => n.toString().padLeft(2, '0');

  final dia = dois(localDate.day);
  final mes = dois(localDate.month);
  final ano = localDate.year.toString();

  final hora = dois(localDate.hour);
  final minuto = dois(localDate.minute);

  return "$dia/$mes/$ano $hora:$minuto";
}

}
