import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoPlano extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool filled;

  const BotaoPlano({
    Key? key,
    required this.text,
    required this.onPressed,
    this.filled = false,
  }) : super(key: key);

  @override
  State<BotaoPlano> createState() => _BotaoPlanoState();
}

class _BotaoPlanoState extends State<BotaoPlano> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: SizedBox(
        width: 100,
        height: 70,
        child: OutlinedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              return widget.filled ? Colors.deepPurple : Colors.transparent;
            }),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            side: WidgetStateProperty.resolveWith((states) {
              if (!widget.filled && isHover) {
                return const BorderSide(color: Colors.deepPurple, width: 2);
              }
              return BorderSide(
                color: widget.filled
                    ? Colors.deepPurple
                    : Colors.deepPurple.shade100,
                width: widget.filled ? 2 : (isHover ? 2 : 1),
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
                color: widget.filled
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
