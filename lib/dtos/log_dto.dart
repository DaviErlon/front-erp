import 'package:fronterp/dtos/funcionario_dto.dart';
import 'package:fronterp/utils/utils.dart';

class LogDto {
  // ===== CAMPOS PRIVADOS =====
  String _id;
  FuncionarioDto _emissor;
  String _nome;
  String _telefone;
  String _cpf;
  String _email;
  String _setor;
  String _acao;
  String _entidade;
  String _detalhes;
  String _dataEmissao;

  LogDto({
    required String id,
    required FuncionarioDto emissor,
    required String nome,
    required String telefone,
    required String cpf,
    required String email,
    required String setor,
    required String acao,
    required String entidade,
    required String detalhes,
    required String dataEmissao,
  })  : _id = id,
        _emissor = emissor,
        _nome = nome,
        _telefone = telefone,
        _cpf = cpf,
        _email = email,
        _setor = setor,
        _acao = acao,
        _entidade = entidade,
        _detalhes = detalhes,
        _dataEmissao = dataEmissao;

  // ===== GETTERS =====
  String get id => _id;
  FuncionarioDto get emissor => _emissor;
  String get nome => _nome;
  String get telefone => _telefone;
  String get cpf => _cpf;
  String get email => _email;
  String get setor => _setor;
  String get acao => _acao;
  String get entidade => _entidade;
  String get detalhes => _detalhes;
  String get dataEmissao => Util.formatarDataOffset(_dataEmissao);

  // ===== SETTERS =====
  set id(String value) => _id = value;
  set emissor(FuncionarioDto value) => _emissor = value;
  set nome(String value) => _nome = value;
  set telefone(String value) => _telefone = value;
  set cpf(String value) => _cpf = value;
  set email(String value) => _email = value;
  set setor(String value) => _setor = value;
  set acao(String value) => _acao = value;
  set entidade(String value) => _entidade = value;
  set detalhes(String value) => _detalhes = value;
  set dataEmissao(String value) => _dataEmissao = value;

  // ===== FROM JSON =====
  factory LogDto.fromJson(Map<String, dynamic> json) {
    return LogDto(
      id: json['id'],
      emissor: FuncionarioDto.fromJson(json['emissor']),
      nome: json['nome'],
      telefone: json['telefone'],
      cpf: json['cpf'],
      email: json['email'],
      setor: json['setor'],
      acao: json['acao'],
      entidade: json['entidade'],
      detalhes: json['detalhes'],
      dataEmissao: json['criadoEm'],
    );
  }
}
