import 'package:flutter/material.dart';
import 'package:fronterp/components/filtrosdialog/filtro_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltroLog extends StatefulWidget {
  const FiltroLog({super.key});
  @override
  State<FiltroLog> createState() => _FiltroLogState();
}

class _FiltroLogState extends State<FiltroLog> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FiltrosDialog(
      maxWidth: 480,
      children: [
        Text(
          "Selecionar Data e Hora",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),

        // Calendário
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: CalendarDatePicker(
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            onDateChanged: (date) {
              setState(() {
                selectedDate = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  selectedDate.hour,
                  selectedDate.minute,
                );
              });
            },
          ),
        ),
        const SizedBox(height: 20),

        // Exibe hora atual
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hora selecionada:", style: GoogleFonts.inter(fontSize: 16)),
            Text(
              "${selectedDate.hour.toString().padLeft(2, '0')}:${selectedDate.minute.toString().padLeft(2, '0')}",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Botão para abrir TimePicker custom
        ElevatedButton.icon(
          icon: const Icon(Icons.schedule),
          label: const Text("Selecionar Hora"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            final time = await showCustomTimePicker(context);
            if (time != null) {
              setState(() {
                selectedDate = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  time.hour,
                  time.minute,
                );
              });
            }
          },
        ),
      ],
      onPressed: () {
        Navigator.pop(context, selectedDate);
      },
    );
  }
}

// ============================
// TIME PICKER CUSTOMIZADO
// ============================

Future<TimeOfDay?> showCustomTimePicker(BuildContext context) async {
  return showDialog<TimeOfDay>(
    context: context,
    builder: (context) {
      TimeOfDay selected = TimeOfDay.now();

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(20),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // HORAS E MINUTOS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _numberSelector(
                      initial: selected.hour,
                      max: 23,
                      onChanged: (v) {
                        setState(() {
                          selected = TimeOfDay(
                            hour: v,
                            minute: selected.minute,
                          );
                        });
                      },
                    ),
                    const Text(
                      ":",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _numberSelector(
                      initial: selected.minute,
                      max: 59,
                      onChanged: (v) {
                        setState(() {
                          selected = TimeOfDay(
                            hour: selected.hour,
                            minute: v,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),

        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context, selected),
          ),
        ],
      );
    },
  );
}

// ============================
// Widgets auxiliares
// ============================

Widget _numberSelector({
  required int initial,
  required int max,
  required Function(int) onChanged,
}) {
  int value = initial;

  return StatefulBuilder(
    builder: (context, setState) {
      return Column(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_drop_up, size: 30),
            onPressed: () {
              setState(() {
                value = (value + 1) % (max + 1);
                onChanged(value);
              });
            },
          ),

          Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),

          IconButton(
            icon: const Icon(Icons.arrow_drop_down, size: 30),
            onPressed: () {
              setState(() {
                value = (value - 1) < 0 ? max : value - 1;
                onChanged(value);
              });
            },
          ),
        ],
      );
    },
  );
}
