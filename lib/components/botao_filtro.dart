import 'package:flutter/material.dart';
import 'package:fronterp/utils/utils.dart';

class BotaoFiltro extends StatefulWidget {
  final ControllerGenerico<Pesquisa> controller;
  final String texto;
  final Pesquisa filtro;

  const BotaoFiltro({
    super.key,
    required this.controller,
    required this.texto,
    required this.filtro,
  });

  @override
  State<BotaoFiltro> createState() => _BotaoFiltroState();
}

class _BotaoFiltroState extends State<BotaoFiltro> {
  @override
  Widget build(BuildContext context) {
    bool selecionado = widget.controller.isSelecionado(widget.filtro);

    return InkWell(
      onTap: () {
        widget.controller.data = widget.filtro;
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Row(
        spacing: 8,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selecionado ? Colors.deepPurple : Colors.grey,
                width: 2,
              ),
            ),
            child: selecionado
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          Text(widget.texto, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}
