import 'package:dio/dio.dart';
import '../services/dio_client.dart';

import '../dtos/pagina_dto.dart';
import '../dtos/produto_dto.dart';
import '../dtos/fornecedor_dto.dart';
import '../dtos/titulo_dto_out.dart';

class AlmoxarifeService {
  static final Dio _dio = DioClient.instance;
  static const String s = '/almoxarife';

  static Future<void> addProduto(ProdutoDto dto) async {
    await _dio.post('$s/produtos', data: dto.toJson());
  }

  static Future<PaginaDto<ProdutoDto>> getProdutos({
    String? nome,
    bool? semEstoque,
    bool? comEstoquePendente,
    bool? comEstoqueReservado,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '$s/produtos',
      queryParameters: {
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (semEstoque != null) 'semEstoque': semEstoque,
        if (comEstoquePendente != null)
          'comEstoquePendente': comEstoquePendente,
        if (comEstoqueReservado != null)
          'comEstoqueReservado': comEstoqueReservado,
        'pagina': pagina,
      },
    );

    return PaginaDto.fromJson(
      response.data,
      (json) => ProdutoDto.fromJson(json),
    );
  }

  static Future<void> setProduto(String id, ProdutoDto dto) async {
    await _dio.put('$s/produtos/$id', data: dto.toJson());
  }

  static Future<void> delProduto(String id) async {
    await _dio.delete('$s/produtos/$id');
  }

  // ============================
  //       FORNECEDORES
  // ============================

  static Future<void> addFornecedor(FornecedorDto dto) async {
    await _dio.post('$s/fornecedores', data: dto.toJson());
  }

  static Future<void> setFornecedor(String id, FornecedorDto dto) async {
    await _dio.put('$s/fornecedores/$id', data: dto.toJson());
  }

  static Future<void> delFornecedor(String id) async {
    await _dio.delete('$s/fornecedores/$id');
  }

  static Future<PaginaDto<FornecedorDto>> getFornecedores({
    String? cpf,
    String? cnpj,
    String? nome,
    String? telefone,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '$s/fornecedores',
      queryParameters: {
        if (cpf != null && cpf.isNotEmpty) 'cpf': cpf,
        if (cnpj != null && cnpj.isNotEmpty) 'cnpj': cnpj,
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (telefone != null && telefone.isNotEmpty) 'telefone': telefone,
        'pagina': pagina,
      },
    );

    return PaginaDto.fromJson(
      response.data,
      (json) => FornecedorDto.fromJson(json),
    );
  }

  // ============================
  //          TÍTULOS
  // ============================

  static Future<void> receberTitulo(String id) async {
    await _dio.put('$s/titulos/$id');
  }

  static Future<PaginaDto<TituloDtoOut>> getTitulos({
    String? nome,
    String? cpf,
    String? cnpj,
    String? telefone,
    DateTime? inicio,
    DateTime? fim,
    bool? pago,
    bool? recebido,
    bool? aprovado,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '$s/titulos',
      queryParameters: {
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (cpf != null && cpf.isNotEmpty) 'cpf': cpf,
        if (cnpj != null && cnpj.isNotEmpty) 'cnpj': cnpj,
        if (telefone != null && telefone.isNotEmpty) 'telefone': telefone,
        if (inicio != null) 'inicio': inicio.toIso8601String(),
        if (fim != null) 'fim': fim.toIso8601String(),
        if (pago != null) 'pago': pago,
        if (recebido != null) 'recebido': recebido,
        if (aprovado != null) 'aprovado': aprovado,
        'pagina': pagina,
      },
    );

    return PaginaDto.fromJson(
      response.data,
      (json) => TituloDtoOut.fromJson(json),
    );
  }
}
