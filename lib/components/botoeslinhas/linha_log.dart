import 'package:flutter/material.dart';
import 'package:fronterp/dtos/log_auditoria_dto.dart';

class LinhaLog extends StatelessWidget {
  final LogAuditoriaDto log;
  final bool isEven;
  final VoidCallback? onTap;

  const LinhaLog({
    super.key,
    required this.log,
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
              width: 360,
              child: Center(
                child: Text(log.nome, style: const TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              width: 100,
              child: Center(
                child: Text(log.acao, style: const TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              width: 100,
              child: Center(
                child: Text(
                  log.entidade,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  log.data,
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
