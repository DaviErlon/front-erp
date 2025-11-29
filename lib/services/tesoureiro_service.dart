import 'package:dio/dio.dart';

import '../services/dio_client.dart';

import '../dtos/pagina_dto.dart';
import '../dtos/produto_dto.dart';
import '../dtos/fornecedor_dto.dart';
import '../dtos/funcionario_dto.dart';
import '../dtos/titulo_dto.dart';

class TesoureiroService {
  static final Dio _dio = DioClient.instance;
  static const String s = '/tesoureiro';

  // ============================
  //          TÍTULOS
  // ============================

  static Future<PaginaDto<TituloDto>> getTitulos({
    String? nome,
    String? cpf,
    String? cnpj,
    String? telefone,
    DateTime? inicio,
    DateTime? fim,
    bool? pago,
    bool? recebido,
    bool? aprovado,
    bool? pagarOuReceber,
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
        if (pagarOuReceber != null) 'pagarOuReceber': pagarOuReceber,
        'pagina': pagina,
      },
    );

    return PaginaDto.fromJson(
      response.data,
      (json) => TituloDto.fromJson(json),
    );
  }

  static Future<void> pagarTitulo(String id) async {
    await _dio.put('$s/titulos/$id');
  }

  // ============================
  //        FUNCIONÁRIOS
  // ============================

  static Future<PaginaDto<FuncionarioDto>> getFuncionarios({
    String? nome,
    String? cpf,
    String? telefone,
    String? tipo,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '$s/funcionarios',
      queryParameters: {
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (cpf != null && cpf.isNotEmpty) 'cpf': cpf,
        if (telefone != null && telefone.isNotEmpty) 'telefone': telefone,
        if (tipo != null) 'tipo': tipo,
        'pagina': pagina,
      },
    );

    return PaginaDto.fromJson(
      response.data,
      (json) => FuncionarioDto.fromJson(json),
    );
  }

  // ============================
  //        FORNECEDORES
  // ============================

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
  //          PRODUTOS
  // ============================

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
}
