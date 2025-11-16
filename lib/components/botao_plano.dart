import 'package:flutter/material.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoPlano extends StatefulWidget {
  final String text;
  final ControllerGenerico<Plano> controller;
  final Plano plano;

  const BotaoPlano({
    super.key,
    required this.text,
    required this.controller,
    required this.plano,
  });

  @override
  State<BotaoPlano> createState() => _BotaoPlanoState();
}

class _BotaoPlanoState extends State<BotaoPlano> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {

    bool filled = widget.controller.isSelecionado(widget.plano);

    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: SizedBox(
        width: 100,
        height: 70,
        child: OutlinedButton(
          onPressed: () => widget.controller.data = widget.plano,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              return filled ? Colors.deepPurple : Colors.transparent;
            }),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            side: WidgetStateProperty.resolveWith((states) {
              if (!filled && isHover) {
                return const BorderSide(color: Colors.deepPurple, width: 2);
              }
              return BorderSide(
                color: filled
                    ? Colors.deepPurple
                    : Colors.deepPurple.shade100,
                width: filled ? 2 : (isHover ? 2 : 1),
              );
            }),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            minimumSize: WidgetStateProperty.all(const Size(100, 70)), // garante tamanho
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // não aumenta o tamanho
          ),
          child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: filled
                    ? Colors.white
                    : (isHover ? Colors.deepPurple : Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
