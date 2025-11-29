import 'package:flutter/material.dart';
import 'package:fronterp/dtos/produto_dto.dart';

class LinhaProduto extends StatelessWidget {
  final ProdutoDto produto;
  final bool isEven;
  final VoidCallback? onTap;

  const LinhaProduto({
    super.key,
    required this.produto,
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
              width: 400,
              child: Center(
                child: Text(produto.nome, style: const TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  "R\$ ${produto.preco.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 70,
              child: Center(
                child: Text(
                  ("${produto.estoqueDisponivel}"),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 70,
              child: Center(
                child: Text(
                  ("${produto.estoqueReservado}"),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 70,
              child: Center(
                child: Text(
                  ("${produto.estoquePendente}"),
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
