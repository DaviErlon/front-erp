class LoginDto {
  final String email;
  final String senha;

  LoginDto({
    required this.email,
    required this.senha,
  });

  //esse vai mapear pra json (tipo struct, so que com dynamic deixa ele generico) // o string no map e pq json a chave(o nome do item tipo token, plano) sempre string, e o dynamic eh pro valor 
  Map<String, dynamic> toJson(){
    return{
      'email': email;
      'senha': senha; 
    };
  }
}