import 'package:dio/dio.dart';
import 'package:fronterp/dtos/login_dto.dart';
import 'package:fronterp/dtos/resposta_dto.dart';
import 'package:fronterp/services/data_storage.dart';
import 'package:fronterp/services/dio_client.dart';

class LoginService {
  static final Dio _dio = DioClient.instance;

  static Future<RespostaDto> login(LoginDto dto) async {
      final response = await _dio.post('/login', data: dto.toJson());
      return RespostaDto.fromJson(response.data);
  }
}
