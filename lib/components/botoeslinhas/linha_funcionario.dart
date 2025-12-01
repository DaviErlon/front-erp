import 'package:flutter/material.dart';
import 'package:fronterp/dtos/funcionario_dto.dart';

class LinhaFuncionario extends StatelessWidget {
  final FuncionarioDto funcionario;
  final bool isEven;
  final VoidCallback? onTap;

  const LinhaFuncionario({
    super.key,
    required this.funcionario,
    required this.isEven,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = isEven ? Colors.grey[200] : Colors.grey[50];

    return InkWell(
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: background),
        child: Row(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              child: Center(
                child: Text(funcionario.tipo.isEmpty ? 'Não especializado' : funcionario.tipo, style: const TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              width: 360,
              child: Center(
                child: Text(funcionario.nome, style: const TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  funcionario.cpf,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  funcionario.telefone.isEmpty ? 'Sem telefone' : funcionario.telefone,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
