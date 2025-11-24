import 'package:dio/dio.dart';
import 'package:fronterp/dtos/cadastro_funcionario_dto.dart';
import 'package:fronterp/dtos/cliente_dto.dart';
import 'package:fronterp/dtos/fornecedor_dto.dart';
import 'package:fronterp/dtos/funcionario_dto.dart';
import 'package:fronterp/dtos/log_auditoria_dto.dart';
import 'package:fronterp/dtos/pagina_dto.dart';
import 'package:fronterp/dtos/produto_dto.dart';
import 'package:fronterp/dtos/titulo_dto_out.dart';
import 'package:fronterp/services/dio_client.dart';

class CeoService {
  static final Dio _dio = DioClient.instance;

  // -------------------- PRODUTOS --------------------

  static Future<void> addProduto(ProdutoDto dto) async {
    await _dio.post('/produtos', data: dto.toJson());
  }

  static Future<void> deleteProduto(String id) async {
    await _dio.delete('/produtos/$id');
  }

  static Future<void> setProduto(ProdutoDto dto, String id) async {
    await _dio.put('/produtos/$id', data: dto.toJson());
  }

  static Future<PaginaDto<ProdutoDto>> getProdutos({
    String? nome,
    bool? semEstoqueFisico,
    bool? comEstoquePendente,
    bool? comEstoqueReservado,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '/produtos',
      queryParameters: {
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (semEstoqueFisico != null) 'semEstoqueFisico': semEstoqueFisico,
        if (comEstoquePendente != null) 'comEstoquePendente': comEstoquePendente,
        if (comEstoqueReservado != null) 'comEstoqueReservado': comEstoqueReservado,
        'pagina': pagina,
      },
    );

    return PaginaDto<ProdutoDto>.fromJson(
      response.data,
      (json) => ProdutoDto.fromJson(json),
    );
  }

  // -------------------- FUNCIONÁRIOS --------------------

  static Future<void> addFuncionario(FuncionarioDto dto) async {
    await _dio.post('/funcionarios', data: dto.toJson());
  }

  static Future<void> deleteFuncionario(String id) async {
    await _dio.delete('/funcionarios/$id');
  }

  static Future<void> setFuncionario(FuncionarioDto dto, String id) async {
    await _dio.put('/funcionarios/$id', data: dto.toJson());
  }

  static Future<void> promoFuncionario(
    CadastroFuncionarioDto dto,
    String id,
  ) async {
    await _dio.put('/funcionarios/promo/$id', data: dto.toJson());
  }

  static Future<PaginaDto<FuncionarioDto>> getFuncionarios({
    String? nome,
    String? cpf,
    String? telefone,
    String? tipo,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '/funcionarios',
      queryParameters: {
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (cpf != null && cpf.isNotEmpty) 'cpf': cpf,
        if (telefone != null && telefone.isNotEmpty) 'telefone': telefone,
        if (tipo != null && tipo.isNotEmpty) 'tipo': tipo,
        'pagina': pagina,
      },
    );

    return PaginaDto<FuncionarioDto>.fromJson(
      response.data,
      (json) => FuncionarioDto.fromJson(json),
    );
  }

  // -------------------- TÍTULOS --------------------

  static Future<void> aprovarTitulo(String id) async {
    await _dio.put('/titulos/$id');
  }

  static Future<void> deleteTitulo(String id) async {
    await _dio.delete('/titulos/$id');
  }

  static Future<PaginaDto<TituloDtoOut>> getTitulos({
    String? nome,
    String? cpf,
    String? cnpj,
    String? telefone,
    bool? pago,
    bool? recebido,
    bool? aprovado,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '/titulos',
      queryParameters: {
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (cpf != null && cpf.isNotEmpty) 'cpf': cpf,
        if (cnpj != null && cnpj.isNotEmpty) 'cnpj': cnpj,
        if (telefone != null && telefone.isNotEmpty) 'telefone': telefone,
        if (pago != null) 'pago': pago,
        if (recebido != null) 'recebido': recebido,
        if (aprovado != null) 'aprovado': aprovado,
        'pagina': pagina,
      },
    );

    return PaginaDto<TituloDtoOut>.fromJson(
      response.data,
      (json) => TituloDtoOut.fromJson(json),
    );
  }

  // -------------------- CLIENTES --------------------

  static Future<void> addCliente(ClienteDto dto) async {
    await _dio.post('/clientes', data: dto.toJson());
  }

  static Future<PaginaDto<ClienteDto>> getClientes({
    String? nome,
    String? cpf,
    String? telefone,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '/clientes',
      queryParameters: {
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (cpf != null && cpf.isNotEmpty) 'cpf': cpf,
        if (telefone != null && telefone.isNotEmpty) 'telefone': telefone,
        'pagina': pagina,
      },
    );

    return PaginaDto<ClienteDto>.fromJson(
      response.data,
      (json) => ClienteDto.fromJson(json),
    );
  }

  // -------------------- FORNECEDORES --------------------

  static Future<void> addFornecedor(FornecedorDto dto) async {
    await _dio.post('/fornecedores', data: dto.toJson());
  }

  static Future<PaginaDto<FornecedorDto>> getFornecedores({
    String? nome,
    String? cpf,
    String? cnpj,
    String? telefone,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '/fornecedores',
      queryParameters: {
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (cpf != null && cpf.isNotEmpty) 'cpf': cpf,
        if (cnpj != null && cnpj.isNotEmpty) 'cnpj': cnpj,
        if (telefone != null && telefone.isNotEmpty) 'telefone': telefone,
        'pagina': pagina,
      },
    );

    return PaginaDto<FornecedorDto>.fromJson(
      response.data,
      (json) => FornecedorDto.fromJson(json),
    );
  }

  // -------------------- LOGS --------------------

  static Future<PaginaDto<LogAuditoriaDto>> getLogs({
    String? nome,
    String? cpf,
    String? telefone,
    String? acao,
    DateTime? inicio,
    DateTime? fim,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '/logs',
      queryParameters: {
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (cpf != null && cpf.isNotEmpty) 'cpf': cpf,
        if (telefone != null && telefone.isNotEmpty) 'telefone': telefone,
        if (acao != null && acao.isNotEmpty) 'acao': acao,
        if (inicio != null) 'inicio': inicio.toIso8601String(),
        if (fim != null) 'fim': fim.toIso8601String(),
        'pagina': pagina,
      },
    );

    return PaginaDto<LogAuditoriaDto>.fromJson(
      response.data,
      (json) => LogAuditoriaDto.fromJson(json),
    );
  }
}
