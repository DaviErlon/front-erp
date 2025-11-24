class LogAuditoriaDto {
  String _id;
  String _idEmissor;
  String _nome;
  String _cpf;
  String _email;
  String _telefone;
  String _setor;
  String _acao;
  String _entidade;
  String _entidadeId;
  String _detalhes;
  DateTime? data;
  DateTime? inicio;
  DateTime? fim;

  LogAuditoriaDto({
    String id = '',
    String idEmissor = '',
    required String nome,
    required String cpf,
    String email = '',
    required String telefone,
    String setor = '',
    required String acao,
    String entidade = '',
    String entidadeId = '',
    String detalhes = '',
    this.data,
    this.inicio,
    this.fim,
  })  : _id = id,
        _idEmissor = idEmissor,
        _nome = nome,
        _cpf = cpf,
        _email = email,
        _telefone = telefone,
        _setor = setor,
        _acao = acao,
        _entidade = entidade,
        _entidadeId = entidadeId,
        _detalhes = detalhes;

  String get id => _id;
  String get idEmissor => _idEmissor;
  String get nome => _nome;
  String get cpf => _cpf;
  String get email => _email;
  String get telefone => _telefone;
  String get setor => _setor;
  String get acao => _acao;
  String get entidade => _entidade;
  String get entidadeId => _entidadeId;
  String get detalhes => _detalhes;

  set id(String v) => _id = v;
  set idEmissor(String v) => _idEmissor = v;
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
      idEmissor: json['idEmissor'],
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      telefone: json['telefone'],
      setor: json['setor'],
      acao: json['acao'],
      entidade: json['entidade'],
      entidadeId: json['entidadeId'],
      detalhes: json['detalhes'],
      data: DateTime.parse(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'cpf': _cpf,
      'telefone': _telefone,
      'acao': _acao,
      if(inicio != null) 'inicio': inicio!.toIso8601String(),
      if(fim != null) 'fim': fim!.toIso8601String(),
    };
  }
}
