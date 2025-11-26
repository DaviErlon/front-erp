import 'package:flutter/material.dart';
import 'package:fronterp/dtos/titulo_dto_out.dart';

class LinhaTitulo extends StatelessWidget {
  final TituloDtoOut titulo;
  final bool isEven;
  final VoidCallback? onTap;

  const LinhaTitulo({
    super.key,
    required this.titulo,
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
        decoration: BoxDecoration(
          color: background,
        ),
        child: Row(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 240,
              child: Center(
                child: Text(titulo.nome, style: const TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              width: 140,
              child: Center(
                child: Text(titulo.cnpj ?? titulo.cpf ?? "SEM CPF", style: const TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              width: 180,
              child: Center(
                child: Text("R\$ ${titulo.valor.toStringAsFixed(2)}", style: const TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(TituloDtoOut.formatarDataOffset(titulo.dataEmissao), style: const TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
