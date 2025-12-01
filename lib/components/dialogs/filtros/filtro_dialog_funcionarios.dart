import 'package:flutter/material.dart';
import 'package:fronterp/components/dialogs/filtros/filtro_dialog.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltrosDialogFuncionarios extends StatefulWidget {
  const FiltrosDialogFuncionarios({super.key});

  @override
  State<FiltrosDialogFuncionarios> createState() =>
      _FiltrosDialogFuncionariosState();
}

class _FiltrosDialogFuncionariosState extends State<FiltrosDialogFuncionarios> {
  Funcionario? _funcionario;

  Widget _buildButton({
    required String texto,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 200,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: isSelected
              ? const Color.fromARGB(255, 144, 117, 189)
              : Colors.transparent,
          side: BorderSide(
            color: isSelected
                ? const Color.fromARGB(255, 144, 117, 189)
                : Colors.black87,
            width: 0.8,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: onTap,
        child: Text(
          texto,
          style: GoogleFonts.roboto(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FiltrosDialog(
      maxWidth: 250,
      children: Funcionario.values.map((f) {
        return Padding(
          padding: EdgeInsetsGeometry.only(bottom: 10),
          child: _buildButton(
            texto: f.name,
            isSelected: _funcionario == f,
            onTap: () {
              setState(() {
                _funcionario = f;
              });
            },
          ),
        );
      }).toList(),
      onPressed: () {
        Navigator.pop(context, _funcionario);
      },
    );
  }
}
