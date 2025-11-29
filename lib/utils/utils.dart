
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_state.dart';

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

  ControllerDialogTitulos({
    bool? pago,
    bool? aprovado,
    bool? recebido,
  })  : _pago = pago,
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

  void clear(){
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

mixin LogoutMixin {
  Future<void> doLogout(BuildContext context) async {
    await context.read<AuthState>().logout();
    context.go('/');
  }
}


enum Funcionario { ceo, gestor, operador, almoxarife, financeiro, tesoureiro}

enum Plano { basico, intermediario, completo, nenhum }

enum Pesquisa { cpf, cnpj, nome, telefone }
