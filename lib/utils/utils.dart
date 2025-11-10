import 'package:flutter/material.dart';

class TipoPlano {
  Plano _plano = Plano.basico;

  Plano get plano => _plano;

  set altplano(Plano novoPlano) {
    _plano = novoPlano;
  }
}

enum Plano { basico, intermediario, completo }

class SenhaOculta {
  bool _visivel = false;

  bool get visivel => _visivel;

  set visivel(bool value) => _visivel = value;

  void alternar() => _visivel = !_visivel;
}

class ModuloSelecionado {
  final VoidCallback onPressed;

  ModuloSelecionado({required this.onPressed});

  int _modulo = 0;

  bool isSelecionado(int id) {
    return _modulo == id;
  }

  get modulo => _modulo;

  set modulo(int m) {
    _modulo = m;
    onPressed();
  }
}
