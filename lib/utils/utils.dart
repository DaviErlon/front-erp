
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

  ControllerDialogTitulos({bool? pago, bool? aprovado, bool? recebido})
    : _pago = pago,
      _aprovado = aprovado,
      _recebido = recebido;

  set pago(bool? p) => _pago = p;
  set aprovado(bool? p) => _aprovado = p;
  set recebido(bool? p) => _recebido = p;

  bool? get pago => _pago;
  bool? get aprovado => _aprovado;
  bool? get recebido => _recebido;

  void updateFromMap(Map<String, dynamic> data) {
    if (data.containsKey('pago') && (data['pago'] is bool?)) {
      _pago = data['pago'];
    }

    if (data.containsKey('aprovado') && (data['aprovado'] is bool?)) {
      _aprovado = data['aprovado'];
    }

    if (data.containsKey('recebido') && (data['recebido'] is bool?)) {
      _recebido = data['recebido'];
    }
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
