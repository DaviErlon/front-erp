import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fronterp/utils/utils.dart';

class BotaoSidebar extends StatelessWidget {
  final ModuloSelecionado moduloSelecionado;
  final String texto;
  final int id;
  final IconData icone;
  const BotaoSidebar({
    super.key,
    required this.texto,
    required this.id,
    required this.icone,
    required this.moduloSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    bool selecionado = moduloSelecionado.isSelecionado(id);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: ElevatedButton(
        onPressed: () {
          moduloSelecionado.modulo = id;
          
        },
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          ),
          backgroundColor: WidgetStateProperty.all(
            selecionado ? Colors.deepPurple : Colors.white,
          ),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          ),
          elevation: WidgetStateProperty.all(0),
          fixedSize: WidgetStateProperty.all(const Size(250, 50)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(left: 62, right: 8),
              child: Icon(
                icone,
                size: 20,
                color: selecionado ? Colors.white : Colors.deepPurple,
              ),
            ),
            Text(
              texto,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: selecionado ? Colors.white : Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
