import 'package:dio/dio.dart';
import 'package:fronterp/dtos/cadastro_dto.dart';
import 'package:fronterp/dtos/login_dto.dart';
import 'package:fronterp/services/dio_client.dart';
import 'package:fronterp/services/login_service.dart';

class CadastroService {
  static final Dio _dio = DioClient.instance;

  static Future<void> cadastro(CadastroDto dto) async {
      await _dio.post(
        '/cadastro',
        data: dto.toJson(),
      );

      await LoginService.login(
        LoginDto(email: dto.email, senha: dto.senha),
      );
  }
}
