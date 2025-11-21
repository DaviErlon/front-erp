import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dtos/login_dto.dart';
import '../dtos/resposta_dto.dart';
import 'dio_client.dart';

class AuthService {
  // LOGIN
  Future<RespostaDto> login(LoginDto dto) async {
    final dio = getDio();

    final response = await dio.post(
      '/api/auth/login', // coloque seu endpoint correto
      data: dto.toJson(),
    );

    final resposta = RespostaDto.fromJson(response.data);

    // Salva token no shared storage
    await _saveToken(resposta.token);

    return resposta;
  }

  // pega token do shared storage
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // salva token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // limpa token
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
