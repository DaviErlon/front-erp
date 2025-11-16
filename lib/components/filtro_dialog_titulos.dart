import 'package:flutter/material.dart';
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
              color: isSelected ? const Color.fromARGB(255, 144, 117, 189) : Colors.black87,
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
                setState(() {
                  onChanged(value == true ? null : true);
                });
              },
            ),
            const SizedBox(width: 10),
            buildButton(
              texto: "Não",
              isSelected: value == false,
              onTap: () {
                setState(() {
                  onChanged(value == false ? null : false);
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filtros",
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _boolSelector(
                label: "Aprovado",
                value: aprovado,
                onChanged: (v) => aprovado = v,
              ),
              const SizedBox(height: 16),

              _boolSelector(
                label: "Recebido",
                value: recebido,
                onChanged: (v) => recebido = v,
              ),
              const SizedBox(height: 16),

              _boolSelector(
                label: "Pago",
                value: pago,
                onChanged: (v) => pago = v,
              ),

              const SizedBox(height: 26),

              SizedBox(
                width: 140,
                height: 42,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, {
                      'aprovado': aprovado,
                      'recebido': recebido,
                      'pago': pago,
                    });
                  },
                  child: const Text("Aplicar filtros"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
