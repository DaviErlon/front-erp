import 'package:dio/dio.dart';
import 'package:fronterp/dtos/login_dto.dart';
import 'package:fronterp/dtos/resposta_dto.dart';
import 'package:fronterp/services/data_storage.dart';
import 'package:fronterp/services/dio_client.dart';

class LoginService {
  static final Dio _dio = DioClient.instance;

  static Future<void> login(LoginDto dto) async {
  
      final response = await _dio.post('/login', data: dto.toJson());
      RespostaDto res = RespostaDto.fromJson(response.data);

      DataStorage.save(
        nome: res.nome,
        plano: res.plano,
        tipo: res.tipo,
        token: res.token,
      );

      DioClient.setToken(res.token);
  }
}
