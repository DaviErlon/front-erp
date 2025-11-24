class PaginaDto<T> {
  List<T> _dados;
  int _pagina;
  int _tamanho;

  PaginaDto({required List<T> dados, required int pagina, required int tamanho})
    : _dados = dados,
      _pagina = pagina,
      _tamanho = tamanho;

  // Getters
  List<T> get dados => _dados;
  int get pagina => _pagina;
  int get tamanho => _tamanho;

  // Setters
  set dados(List<T> valor) => _dados = valor;
  set pagina(int valor) => _pagina = valor;
  set tamanho(int valor) => _tamanho = valor;

  factory PaginaDto.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginaDto<T>(
      dados: (json['dados'] as List<dynamic>)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
      pagina: json['pagina'] as int,
      tamanho: json['tamanho'] as int,
    );
  }
}
