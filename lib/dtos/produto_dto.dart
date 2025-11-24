class ProdutoDto {
  String _id;
  String _nome;
  double _preco;
  int _quantidade;
  int _estoqueDisponivel;
  int _estoquePendente;
  int _estoqueReservado;

  ProdutoDto({
    String id = '',
    required String nome,
    required double preco,
    int quantidade = 0,
    int estoqueDisponivel = 0,
    int estoquePendente = 0,
    int estoqueReservado = 0,
  })  :_id = id,
        _nome = nome,
        _preco = preco,
        _quantidade = quantidade,
        _estoqueDisponivel = estoqueDisponivel,
        _estoquePendente = estoquePendente,
        _estoqueReservado = estoqueReservado;

  // Getters
  String get id => _id;
  String get nome => _nome;
  double get preco => _preco;
  int get quantidade => _quantidade;
  int get estoqueDisponivel=> _estoqueDisponivel;
  int get estoqueReservado => _estoqueReservado;
  int get estoquePendente => _estoquePendente;


  // Setters
  set nome(String valor) => _nome = valor;
  set preco(double valor) => _preco = valor;
  set quantidade(int valor) => _quantidade = valor;
  set estoqueDisponivel(int valor) => _estoqueDisponivel = valor;
  set estoqueReservado(int valor) => _estoqueReservado = valor;
  set estoquePendente(int valor) => _estoquePendente = valor;

  factory ProdutoDto.fromJson(Map<String, dynamic> json) {
    return ProdutoDto(
      id: json['id'],
      nome: json['nome'],
      preco: json['preco'].toDouble(),
      estoqueDisponivel: json['estoqueDisponivel'] as int,
      estoqueReservado: json['estoqueReservado'] as int,
      estoquePendente: json['estoquePendente'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'preco': _preco,
      'quantidade': _quantidade,
    };
  }
}
