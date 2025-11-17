import 'package:dio/dio.dart';
import 'login_dto.dart';
import 'resposta_dto.dart';


class LoginService {
  final Dio _dio;
  LoginService(this._dio);

  Future<RespostaDTO> login(LoginDTO dto) async {
    final res = await _dio.post('/Login', data: dto.toJson());
    return RespostaDTO.fromJson(res.data);
  
  }
}