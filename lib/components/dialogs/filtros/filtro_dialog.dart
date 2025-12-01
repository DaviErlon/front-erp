import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltrosDialog extends StatefulWidget {

  final double maxWidth;
  final List<Widget> children;
  final VoidCallback onPressed;

  const FiltrosDialog({super.key, required this.maxWidth, required this.children, required this.onPressed});

  @override
  State<FiltrosDialog> createState() => _FiltrosDialogState();
}

class _FiltrosDialogState extends State<FiltrosDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: widget.maxWidth),
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

              ...widget.children,

              const SizedBox(height: 16),

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
                  onPressed: widget.onPressed,
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
