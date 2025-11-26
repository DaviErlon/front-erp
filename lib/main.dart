import 'package:flutter/material.dart';
import 'package:fronterp/pages/almoxarife_page.dart';
import 'package:fronterp/pages/ceo_page.dart';
import 'package:fronterp/pages/operador_page.dart';
import 'package:fronterp/pages/cadastro_page.dart';
import 'package:fronterp/pages/login_page.dart';
import 'package:fronterp/pages/gestor_page.dart';
import 'package:fronterp/pages/loading_page.dart';
import 'package:fronterp/auth/auth_state.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final auth = AuthState();

  final router = GoRouter(
    refreshListenable: auth,

    redirect: (context, state) {
      final logged = auth.isLogged;
      final tipo = auth.tipo;
      final carregado = auth.carregado;
      final loc = state.uri.toString();

      final isLogin = loc == "/";
      final isCadastro = loc == "/cadastro";
      final isLoading = loc == "/loading";

      // 1 — loading
      if (!carregado) {
        if (!isLoading) return "/loading";
        return null;
      }

      // 🔥 2 — liberar páginas públicas ANTES DE QUALQUER VERIFICAÇÃO DE LOGIN
      if (isCadastro) return null;

      // 3 — não logado → só pode ver login
      if (!logged) {
        if (!isLogin) return "/";
        return null;
      }

      // 4 — logado tentando acessar login
      if (logged && isLogin) {
        return "/$tipo";
      }

      // 5 — proteção por tipo
      if (logged && tipo != null) {
        final expected = "/$tipo";
        if (loc != expected && !loc.startsWith("$expected/")) {
          return expected;
        }
      }

      return null;
    },

    routes: [
      GoRoute(path: "/loading", builder: (_, __) => const LoadingPage()),
      GoRoute(path: "/", builder: (_, __) => LoginPage()),
      GoRoute(path: "/cadastro", builder: (_, __) => CadastroPage()),

      // rotas por cargo
      GoRoute(path: "/operador", builder: (_, __) => OperadorPage()),
      GoRoute(path: "/gestor", builder: (_, __) => GestorPage()),
      GoRoute(path: "/ceo", builder: (_, __) => CeoPage()),
      GoRoute(path: "/almoxarife", builder: (_, __) => AlmoxarifePage()),

      // futuras
      GoRoute(path: "/financeiro", builder: (_, __) => Center()),
      GoRoute(path: "/tesoureiro", builder: (_, __) => Center()),
    ],
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
        Locale('en', 'ES'),
      ],
      path: '/translations',
      fallbackLocale: const Locale('pt', 'BR'),
      child: ChangeNotifierProvider.value(
        value: auth,
        child: MyApp(router: router),
      ),
    ),
  );
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

        textTheme: TextTheme(
          titleMedium: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
          labelLarge: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
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
