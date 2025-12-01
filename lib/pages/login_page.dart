import 'package:flutter/material.dart';
import 'package:fronterp/dtos/login_dto.dart';
import 'package:fronterp/services/login_service.dart';
import 'package:fronterp/auth/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:fronterp/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final ControllerGenerico<bool> _senhaOculta = ControllerGenerico(data: false);

  bool _todosPreenchidos = false;

  @override
  void initState() {
    super.initState();
    _senhaController.addListener(_verificarCampos);
    _emailController.addListener(_verificarCampos);
  }

  void _verificarCampos() {
    final preenchidos =
        _emailController.text.isNotEmpty && _senhaController.text.isNotEmpty;
    setState(() => _todosPreenchidos = preenchidos);
  }

  @override
  void dispose() {
    _senhaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _realizarLogin() async {
    if (!_todosPreenchidos) return;

    try {
      final dto = LoginDto(
        email: _emailController.text,
        senha: _senhaController.text,
      );

      final response = await LoginService.login(dto);

      final auth = context.read<AuthState>();
      await auth.login(
        token: response.token,
        tipo: response.tipo,
        nome: response.nome,
        plano: response.plano,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('auth.login.success'.tr()),
        ),
      );

      context.go('/${auth.tipo}');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('auth.login.error'.tr()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: SizedBox(
            width: 360,
            height: 420,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 14,
                  children: [
                    SelectableText(
                      'auth.login.title'.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    const SizedBox(height: 20),

                    // EMAIL
                    TextField(
                      controller: _emailController,
                      decoration: Util.estiloTextFiel(
                        label: 'auth.login.email_label'.tr(),
                        hint: 'auth.login.email_hint'.tr(),
                      ),
                    ),

                    // SENHA
                    TextField(
                      controller: _senhaController,
                      obscureText: !_senhaOculta.data,
                      decoration: Util.estiloTextFiel(
                        label: 'auth.login.password_label'.tr(),
                        hint: 'auth.login.password_hint'.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _senhaOculta.data
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.deepPurple.shade400,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              _senhaOculta.data = !_senhaOculta.data;
                            });
                          },
                        ),
                      ),
                    ),

                    // BOTÃO LOGIN
                    Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 6),
                      child: SizedBox(
                        width: 88,
                        height: 40,
                        child: Opacity(
                          opacity: _todosPreenchidos ? 1 : 0.8,
                          child: ElevatedButton(
                            onPressed: _todosPreenchidos ? _realizarLogin : null,
                            child: Text('auth.login.submit'.tr()),
                          ),
                        ),
                      ),
                    ),

                    // LINK CADASTRO
                    InkWell(
                      onTap: () => context.go('/cadastro'),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Text.rich(
                        TextSpan(
                          text: 'auth.login.no_account'.tr(),
                          style: Theme.of(context).textTheme.labelLarge,
                          children: [
                            TextSpan(
                              text: 'auth.login.signup'.tr(),
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
