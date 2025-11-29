import 'package:flutter/material.dart';
import 'package:fronterp/dtos/cliente_dto.dart';

class LinhaCliente extends StatelessWidget {
  final ClienteDto cliente;
  final bool isEven;
  final VoidCallback? onTap;

  const LinhaCliente({
    super.key,
    required this.cliente,
    required this.isEven,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = isEven ? Colors.grey[200] : Colors.grey[50];

    return InkWell(
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
              width: 440, 
              child: Center(
                child: Text(cliente.nome, style: const TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  cliente.cpf,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  cliente.telefone,
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
