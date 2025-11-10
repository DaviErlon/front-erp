import 'package:flutter/material.dart';
import 'package:fronterp/pages/almoxarife_page.dart';
import 'package:fronterp/pages/ceo_page.dart';
import 'package:fronterp/pages/operador_page.dart';
import 'package:go_router/go_router.dart';
import 'package:fronterp/pages/cadastro_page.dart';
import 'package:fronterp/pages/login_page.dart';
import 'package:fronterp/pages/gestor_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => LoginPage()),
      GoRoute(path: '/cadastro', builder: (context, state) => CadastroPage()),
      GoRoute(path: '/operador', builder: (context, state) => OperadorPage()),
      GoRoute(path: '/gestor', builder: (context, state) => GestorPage()),
      GoRoute(path: '/ceo', builder: (context, state) => CeoPage()),
      GoRoute(path: '/almoxarife', builder: (context, state) => AlmoxarifePage()),
      GoRoute(path: '/financeiro', builder: (context, state) => Center()),
      GoRoute(path: '/tesoureiro', builder: (context, state) => Center()),
    ],
  );

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NEXOS PRISMA ERP',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

        textTheme: TextTheme(
          titleMedium: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
          labelLarge: GoogleFonts.roboto(fontSize: 14),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.deepPurple.withValues(alpha: 0.05),
          labelStyle: GoogleFonts.roboto(
            color: Colors.deepPurple.shade700,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: GoogleFonts.roboto(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.deepPurple.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.deepPurple.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
      ),
    );
  }
}
