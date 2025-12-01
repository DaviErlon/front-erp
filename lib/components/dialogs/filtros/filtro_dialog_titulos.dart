import 'package:flutter/material.dart';
import 'package:fronterp/components/dialogs/filtros/filtro_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltrosDialogTitulos extends StatefulWidget {
  const FiltrosDialogTitulos({super.key});

  @override
  State<FiltrosDialogTitulos> createState() => _FiltrosDialogTitulosState();
}

class _FiltrosDialogTitulosState extends State<FiltrosDialogTitulos> {
  bool? aprovado;
  bool? recebido;
  bool? pago;

  Widget _boolSelector({
    required String label,
    required bool? value,
    required void Function(bool?) onChanged,
  }) {
    Widget buildButton({
      required String texto,
      required bool isSelected,
      required VoidCallback onTap,
    }) {
      return Expanded(
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 6),
        Row(
          children: [
            buildButton(
              texto: "Sim",
              isSelected: value == true,
              onTap: () {
                final newValue = value == true ? null : true;
                onChanged(newValue); // sem setState aqui
              },
            ),
            const SizedBox(width: 10),
            buildButton(
              texto: "Não",
              isSelected: value == false,
              onTap: () {
                final newValue = value == false ? null : false;
                onChanged(newValue); // sem setState aqui
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FiltrosDialog(
      maxWidth: 450,
      children: [
        _boolSelector(
          label: "Aprovado",
          value: aprovado,
          onChanged: (v) => setState(() => aprovado = v),
        ),
        const SizedBox(height: 16),

        _boolSelector(
          label: "Recebido",
          value: recebido,
          onChanged: (v) => setState(() => recebido = v),
        ),
        const SizedBox(height: 16),

        _boolSelector(
          label: "Pago",
          value: pago,
          onChanged: (v) => setState(() => pago = v),
        ),

        const SizedBox(height: 16),
      ],
      onPressed: () {
        Navigator.pop(context, {
          'aprovado': aprovado,
          'recebido': recebido,
          'pago': pago,
        });
      },
    );
  }
}
