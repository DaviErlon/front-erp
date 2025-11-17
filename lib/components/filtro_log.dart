import 'package:flutter/material.dart';
import 'package:fronterp/components/filtro_dialog.dart';
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
        // TÍTULO
        Text(
          "Selecionar Data e Hora",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 20),

        // CALENDÁRIO CUSTOMIZADO
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
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hora selecionada:",
              style: GoogleFonts.inter(fontSize: 16),
            ),
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

        // BOTÃO DE SELECIONAR HORA ESTILIZADO
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

// showDialog Customizado para selecionar a hora de forma mais facil pela web

Future<TimeOfDay?> showCustomTimePicker(BuildContext context) async {
  return showDialog<TimeOfDay>(
    context: context,
    builder: (context) {
      TimeOfDay selected = TimeOfDay.now();

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: EdgeInsets.all(20),
        content: StatefulBuilder(
          builder: (context, setState) {
            bool isPM = selected.period == DayPeriod.pm;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _numberSelector(
                      initial: selected.hourOfPeriod,
                      max: 12,
                      onChanged: (v) {
                        setState(() {
                          selected = TimeOfDay(
                            hour: (isPM ? 12 : 0) + v % 12,
                            minute: selected.minute,
                          );
                        });
                      },
                    ),

                    Text(
                      ":",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _amPmButton(
                      label: "AM",
                      selected: !isPM,
                      onTap: () {
                        setState(() {
                          isPM = false;
                          selected = TimeOfDay(
                            hour: selected.hour % 12,
                            minute: selected.minute,
                          );
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    _amPmButton(
                      label: "PM",
                      selected: isPM,
                      onTap: () {
                        setState(() {
                          isPM = true;
                          selected = TimeOfDay(
                            hour: (selected.hour % 12) + 12,
                            minute: selected.minute,
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
            child: Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context, selected),
          ),
        ],
      );
    },
  );
}

Widget _amPmButton({
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? Colors.deepPurple : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    ),
  );
}

Widget _numberSelector({
  required int initial,
  required int max,
  required Function(int) onChanged,
}) {
  int value = initial;

  return StatefulBuilder(builder: (context, setState) {
    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_drop_up, size: 30),
          onPressed: () {
            setState(() {
              value = (value + 1) % (max + 1);
              onChanged(value);
            });
          },
        ),
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.arrow_drop_down, size: 30),
          onPressed: () {
            setState(() {
              value = (value - 1) < 0 ? max : value - 1;
              onChanged(value);
            });
          },
        ),
      ],
    );
  });
}
