import 'package:flutter/material.dart';
import '../services/dio_client.dart';
import '../services/data_storage.dart';

class AuthState extends ChangeNotifier {
  String? _tipo;
  String? _nome;
  String? _plano;
  String? _token;
  bool _isLogged = false;
  bool _carregado = false;

  // GETTERS
  String? get tipo => _tipo;
  String? get nome => _nome;
  String? get plano => _plano;
  String? get token => _token;
  bool get isLogged => _isLogged;
  bool get carregado => _carregado;

  AuthState() {
    carregar();
  }

  // ============================================================
  // ====================== CARREGAR STORAGE =====================
  // ============================================================
  Future<void> carregar() async {
    final temLogin = await DataStorage.temLogin();

    if (temLogin) {
      _token = await DataStorage.carregarToken();
      _nome = await DataStorage.carregarNome();
      _plano = await DataStorage.carregarPlano();
      _tipo = await DataStorage.carregarTipo();

      if (_token != null && _tipo != null) {
        DioClient.setToken(_token!);
        _isLogged = true;
      } else {
        await logout();
      }
    }

    _carregado = true;
    notifyListeners();
  }

  // ============================================================
  // ========================== LOGIN ============================
  // ============================================================
  Future<void> login({
    required String token,
    required String tipo,
    required String nome,
    required String plano,
  }) async {
    _token = token;
    _tipo = tipo.toLowerCase();
    _nome = nome;
    _plano = plano;
    _isLogged = true;

    DioClient.setToken(token);

    await DataStorage.save(
      token: token,
      nome: nome,
      plano: plano.toLowerCase(),
      tipo: tipo.toLowerCase(),
    );

    notifyListeners();
  }

  // ============================================================
  // ========================= LOGOUT ============================
  // ============================================================
  Future<void> logout() async {
    _token = null;
    _tipo = null;
    _nome = null;
    _plano = null;
    _isLogged = false;

    DioClient.clearToken();
    await DataStorage.clear();

    notifyListeners();
  }
}
