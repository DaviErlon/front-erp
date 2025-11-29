class FuncionarioDto {

  String _id;
  String _cpf;
  double _salario;
  double _bonus;
  String _telefone;
  String _nome;
  String _setor;
  String _tipo;
  String _email;

  FuncionarioDto({ 
    String id = '',
    required String cpf,
    required double salario,
    required double bonus,
    required String telefone,
    required String nome,
    String tipo = '',
    String email = '',
    required String setor,
  })  : _id = id, 
        _cpf = cpf,
        _salario = salario,
        _bonus = bonus,
        _telefone = telefone,
        _nome = nome,
        _tipo = tipo,
        _email = email,
        _setor = setor;

  // Setters
  set cpf(String valor) => _cpf = valor;
  set salario(double valor) => _salario = valor;
  set bonus(double valor) => _bonus = valor;
  set telefone(String valor) => _telefone = valor;
  set nome(String valor) => _nome = valor;
  set setor(String valor) => _setor = valor;
  set email(String valor) => _email = valor;
  set tipo(String valor) => _tipo = valor;
  set id(String valor) => _id = valor;

  // Getters
  String get cpf => _cpf;
  double get salario => _salario;
  double get bonus => _bonus;
  String get telefone => _telefone;
  String get nome => _nome;
  String get setor => _setor;
  String get tipo => _tipo;
  String get email => _email;
  String get id => _id;

  factory FuncionarioDto.fromJson(Map<String, dynamic> json) {
    return FuncionarioDto(
      id: json['id'],
      tipo: json['tipo'] ?? '',
      email: json['email'] ?? '',
      cpf: json['cpf'],
      salario: json['salario'].toDouble(),
      bonus: json['bonus'].toDouble(),
      telefone: json['telefone'] ?? '',
      nome: json['nome'],
      setor: json['setor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cpf': _cpf,
      'salario': _salario,
      'bonus': _bonus,
      'telefone': _telefone,
      'nome': _nome,
      'setor': _setor,
    };
  }
}
