class LoginDto {
  String _email;
  String _senha;

  LoginDto({required String email, required String senha})
    : _email = email,
      _senha = senha;

  //Setters

  set email(String valor) => _email = valor;
  set senha(String valor) => _senha = valor;

  //Getters

  String get email => _email;
  String get senha => _senha;

  Map<String, dynamic> toJson() {
    return {'email': _email, 'senha': _senha};
  }
}
