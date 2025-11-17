import 'package:dio/dio.dart';
import 'package:fronterp/dtos/login_dto.dart';
import 'package:fronterp/dtos/resposta_dto.dart';
import 'package:fronterp/services/dio_client.dart';

class LoginService {
  final Dio _dio;
  LoginService(this._dio);

  Future<RespostaDTO> login(LoginDTO dto) async {
  LoginService() : _dio = getDio();

  Future<RespostaDto> login(LoginDto dto) async {
    try {
      final response = await _dio.post(
        '/login',
        data: dto.toJson(),
      );

      return RespostaDto.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Erro ${e.response!.statusCode}: ${e.response!.data}',
        );
      } else {
        throw Exception('Erro de conexão: ${e.message}');
      }
    }
  }
}
