import 'package:flutter/material.dart';
import 'package:fronterp/dtos/login_dto.dart';
import 'package:fronterp/services/login_services.dart';
import 'package:go_router/go_router.dart';
import 'package:fronterp/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final ControllerGenerico<bool> _senhaOculta = ControllerGenerico(data: false);
  final LoginService servicoLogin = LoginService();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.only(bottom: 40),
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
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 14,
                  children: [
                    SelectableText(
                      'Login',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        hintText: "exemplo@email.com",
                      ),
                    ),
                    TextField(
                      controller: _senhaController,
                      obscureText: !_senhaOculta.data,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        hintText: "Digite sua senha",
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
                    Padding(
                      padding: EdgeInsetsGeometry.only(top: 14, bottom: 6),
                      child: SizedBox(
                        width: 88,
                        height: 40,
                        child: Opacity(
                          opacity: _todosPreenchidos ? 1 : 0.8,
                          child: ElevatedButton(
                            onPressed: _todosPreenchidos
                                ? () async {
                                    final response = await servicoLogin.login(
                                      LoginDto(
                                        email: _emailController.text,
                                        senha: _senhaController.text,
                                      ),
                                    );

                                    if (!mounted) return;

                                    

                                    context.go('/ceo');
                                  }
                                : null, // desativa o botão
                            child: const Text('Login'),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.go('/cadastro');
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Text.rich(
                        TextSpan(
                          text: 'Não possui login? ',
                          style: Theme.of(context).textTheme.labelLarge,
                          children: [
                            TextSpan(
                              text: 'Cadastre-se',
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
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
