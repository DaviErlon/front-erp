import 'package:flutter/material.dart';
import 'package:fronterp/components/filtro_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltrosDialogProdutos extends StatefulWidget {
  const FiltrosDialogProdutos({super.key});

  @override
  State<FiltrosDialogProdutos> createState() => _FiltrosDialogProdutosState();
}

class _FiltrosDialogProdutosState extends State<FiltrosDialogProdutos> {
  bool? esgotado;
  bool? encomendado;
  bool? reservado;

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
      maxWidth: 450,
      children: [
        _buildButton(
          texto: 'esgotado',
          isSelected: esgotado ?? false,
          onTap: () {
            setState(() {
              if (esgotado ?? false) {
                esgotado = false;
              } else {
                esgotado = true;
              }
            });
          },
        ),
        const SizedBox(height: 16),
        _buildButton(
          texto: 'encomendado',
          isSelected: encomendado ?? false,
          onTap: () {
            setState(() {
              if (encomendado ?? false) {
                encomendado = false;
              } else {
                encomendado = true;
              }
            });
          },
        ),
        const SizedBox(height: 16),
        _buildButton(
          texto: 'reservado',
          isSelected: reservado ?? false,
          onTap: () {
            setState(() {
              if (reservado ?? false) {
                reservado = false;
              } else {
                reservado = true;
              }
            });
          },
        ),
        const SizedBox(height: 16),
      ],
      onPressed: () {
        Navigator.pop(context, {
          'esgotado': esgotado,
          'encomendado': encomendado,
          'reservado': reservado,
        });
      },
    );
  }
}
