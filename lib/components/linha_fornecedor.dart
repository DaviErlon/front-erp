import 'package:flutter/material.dart';
import 'package:fronterp/dtos/fornecedor_dto.dart';

class LinhaFornecedor extends StatelessWidget {
  final FornecedorDto fornecedor;
  final bool isEven;
  final VoidCallback? onTap;

  const LinhaFornecedor({
    super.key,
    required this.fornecedor,
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
              width: 280,
              child: Center(
                child: Text(fornecedor.nome, style: const TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              width: 240,
              child: Center(
                child: Text(
                  fornecedor.cnpj.isEmpty ? fornecedor.cpf : fornecedor.cnpj,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: Center(
                child: Text(
                  fornecedor.telefone,
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
