import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  
  static const String keyToken = 'auth_token_erp';
  static const String keyTipo  = 'auth_tipo_erp';
  static const String keyPlano = 'auth_plano_erp';
  static const String keyNome  = 'auth_nome_erp';

  static Future<void> save({required String token, required String nome, required String plano, required String tipo}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyToken, token);
    await prefs.setString(keyNome, nome);
    await prefs.setString(keyPlano, plano);
    await prefs.setString(keyTipo, tipo);
  }
  
  static Future<String?> carregarToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyToken);
  }

  static Future<String?> carregarTipo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyTipo);
  }

  static Future<String?> carregarPlano() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyPlano);
  }

  static Future<String?> carregarNome() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyNome);
  }

  static Future<bool> temLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(keyToken);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyToken);
    await prefs.remove(keyTipo);
    await prefs.remove(keyPlano);
    await prefs.remove(keyNome);
  }
}
