import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_state.dart';
import 'package:google_fonts/google_fonts.dart';

class ControllerGenerico<T> {
  final void Function()? onPressed;

  ControllerGenerico({this.onPressed, required T data}) : _data = data;

  bool isSelecionado(T data) => _data == data;

  T _data;

  T get data => _data;

  set data(T data) {
    _data = data;
    onPressed?.call();
  }
}

class ControllerDialogTitulos {
  bool? _pago;
  bool? _aprovado;
  bool? _recebido;

  ControllerDialogTitulos({bool? pago, bool? aprovado, bool? recebido})
    : _pago = pago,
      _aprovado = aprovado,
      _recebido = recebido;

  // GETTERS
  bool? get pago => _pago;
  bool? get aprovado => _aprovado;
  bool? get recebido => _recebido;

  // SETTERS
  set pago(bool? p) => _pago = p;
  set aprovado(bool? p) => _aprovado = p;
  set recebido(bool? p) => _recebido = p;

  // Atualiza somente se o valor for bool ou null
  void updateFromMap(Map<String, dynamic> data) {
    if (data.containsKey('pago')) {
      final v = data['pago'];
      if (v == null || v is bool) _pago = v;
    }

    if (data.containsKey('aprovado')) {
      final v = data['aprovado'];
      if (v == null || v is bool) _aprovado = v;
    }

    if (data.containsKey('recebido')) {
      final v = data['recebido'];
      if (v == null || v is bool) _recebido = v;
    }
  }

  void clear() {
    _pago = null;
    _aprovado = null;
    _recebido = null;
  }
}

class ControllerDialogProdutos {
  bool? _esgotado;
  bool? _encomendado;
  bool? _reservado;

  ControllerDialogProdutos({bool? esgotado, bool? encomendado, bool? reservado})
    : _esgotado = esgotado,
      _encomendado = encomendado,
      _reservado = reservado;

  set esgotado(bool? p) => _esgotado = p;
  set encomendado(bool? p) => _encomendado = p;
  set reservado(bool? p) => _reservado = p;

  bool? get esgotado => _esgotado;
  bool? get encomendado => _encomendado;
  bool? get reservado => _reservado;

  void clear() {
    _esgotado = null;
    _encomendado = null;
    _reservado = null;
  }

  void updateFromMap(Map<String, dynamic> data) {
    if (data.containsKey('esgotado') && (data['esgotado'] is bool?)) {
      _esgotado = data['esgotado'];
    }

    if (data.containsKey('encomendado') && (data['encomendado'] is bool?)) {
      _encomendado = data['encomendado'];
    }

    if (data.containsKey('reservado') && (data['reservado'] is bool?)) {
      _reservado = data['reservado'];
    }
  }
}

class Util {
  static String formatarDataOffset(String offsetDateTimeString) {
    final dateTime = DateTime.parse(offsetDateTimeString);

    String dois(int n) => n.toString().padLeft(2, '0');

    final dia = dois(dateTime.day);
    final mes = dois(dateTime.month);
    final ano = dateTime.year.toString();

    final hora = dois(dateTime.hour);
    final minuto = dois(dateTime.minute);

    return "$dia/$mes/$ano $hora:$minuto";
  }

  static InputDecoration estiloTextFiel({
    required String label,
    String? hint,
    Widget? suffixIcon
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixIcon: suffixIcon,

      filled: true,
      fillColor: Colors.deepPurple.withValues(alpha: 0.05),

      labelStyle: GoogleFonts.roboto(
        color: Colors.deepPurple.shade700,
        fontWeight: FontWeight.w500,
      ),

      hintStyle: GoogleFonts.roboto(color: Colors.grey.shade600, fontSize: 14),

      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.deepPurple.shade200),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.deepPurple.shade100),
      ),

      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.deepPurple, width: 2),
      ),
    );
  }
}

mixin LogoutMixin {
  Future<void> doLogout(BuildContext context) async {
    await context.read<AuthState>().logout();
    context.go('/');
  }
}

enum Funcionario { ceo, gestor, operador, almoxarife, financeiro, tesoureiro }

enum Plano { basico, intermediario, completo, nenhum }

enum Pesquisa { cpf, cnpj, nome, telefone }
