import 'package:flutter/material.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class MoldeTela extends StatelessWidget with LogoutMixin {
  final Widget body;
  final Widget sideBar;

  const MoldeTela({super.key, required this.body, required this.sideBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF3F4F6FF),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 4,
            child: Container(
              width: 250,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: 40),
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 100,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                    child: Text(
                      '@nome_func',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox(height: 30),
                  SizedBox(height: 370, child: sideBar),
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => doLogout(context),
                      style: Theme.of(context).elevatedButtonTheme.style
                          ?.copyWith(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.transparent,
                            ),
                            elevation: WidgetStatePropertyAll(0),
                            foregroundColor: WidgetStatePropertyAll(
                              Colors.deepPurple,
                            ),
                            shape:
                                WidgetStateProperty.resolveWith<
                                  RoundedRectangleBorder
                                >((states) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                        color: Colors.deepPurple,
                                        width: 3,
                                      ),
                                    );
                                  }
                                  return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: Colors.deepPurple,
                                      width: 2,
                                    ),
                                  );
                                }),
                            overlayColor: WidgetStatePropertyAll(
                              Colors.deepPurple.withValues(alpha: 0.05),
                            ),
                            textStyle: WidgetStatePropertyAll(
                              const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                      child: const Text("Sair"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(height: 35, color: Colors.deepPurple),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
