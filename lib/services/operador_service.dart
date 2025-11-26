import 'package:dio/dio.dart';

import '../services/dio_client.dart';
import '../dtos/pagina_dto.dart';
import '../dtos/titulo_dto_out.dart';
import '../dtos/item_produto_dto.dart';
import '../dtos/cliente_dto.dart';
import '../dtos/produto_dto.dart';

class OperadorService {
  static final Dio _dio = DioClient.instance;
  static const String s = '/operador';

  // ============================
  //   CRIAÇÃO DE TÍTULOS
  // ============================

  static Future<TituloDtoOut> criarVendaCliente(String clienteId) async {
    final response = await _dio.post('$s/venda/iniciar/$clienteId');
    return TituloDtoOut.fromJson(response.data);
  }

  static Future<TituloDtoOut> criarVenda() async {
    final response = await _dio.post('$s/venda/iniciar');
    return TituloDtoOut.fromJson(response.data);
  }

  static Future<TituloDtoOut> addItemTitulo(
    String tituloId,
    ItemProdutoDto dto,
  ) async {
    final response = await _dio.put(
      '$s/venda/adicionar/$tituloId',
      data: dto.toJson(),
    );
    return TituloDtoOut.fromJson(response.data);
  }

  static Future<TituloDtoOut> finalizarVenda(String tituloId) async {
    final response = await _dio.put('$s/venda/finalizar/$tituloId');
    return TituloDtoOut.fromJson(response.data);
  }

  static Future<TituloDtoOut> cancelarVenda(
    String tituloId,
    String tokenAutorizacao,
  ) async {
    final response = await _dio.delete(
      '$s/venda/cancelar/$tituloId',
      data: tokenAutorizacao,
    );

    return TituloDtoOut.fromJson(response.data);
  }

  // ============================
  //   CLIENTES
  // ============================

  static Future<ClienteDto> cadastrarCliente(ClienteDto dto) async {
    final response = await _dio.post(
      '$s/clientes',
      data: dto.toJson(),
    );

    return ClienteDto.fromJson(response.data);
  }

  static Future<PaginaDto<ClienteDto>> getClientes({
    String? cpf,
    String? nome,
    String? telefone,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '$s/clientes',
      queryParameters: {
        if (cpf != null && cpf.isNotEmpty) 'cpf': cpf,
        if (nome != null && nome.isNotEmpty) 'nome': nome,
        if (telefone != null && telefone.isNotEmpty) 'telefone': telefone,
        'pagina': pagina,
      },
    );

    return PaginaDto.fromJson(
      response.data,
      (json) => ClienteDto.fromJson(json),
    );
  }

  // ============================
  //   PRODUTOS
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

  // ============================
  //   CONSULTAR TÍTULOS EMITIDOS
  // ============================

  static Future<PaginaDto<TituloDtoOut>> getTitulosEmitidos({
    String? cpf,
    String? nome,
    DateTime? inicio,
    DateTime? fim,
    bool? pago,
    bool? recebido,
    bool? aprovado,
    int pagina = 0,
  }) async {
    final response = await _dio.get(
      '$s/vendas',
      queryParameters: {
        if (cpf != null && cpf.isNotEmpty) 'cpf': cpf,
        if (nome != null && nome.isNotEmpty) 'nome': nome,
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
