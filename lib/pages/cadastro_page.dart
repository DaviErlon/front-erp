import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fronterp/components/botao_plano.dart';
import 'package:fronterp/utils/utils.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final ControllerGenerico<bool> _senhaOculta = ControllerGenerico(data: false);

  late ControllerGenerico<Plano> _plano;

  bool _todosPreenchidos = false;

  @override
  void initState() {
    super.initState();
    _nomeController.addListener(_verificarCampos);
    _senhaController.addListener(_verificarCampos);
    _emailController.addListener(_verificarCampos);
    _cpfController.addListener(_verificarCampos);
    _plano = ControllerGenerico(
      onPressed: () {
        setState(() {});
      },
      data: Plano.nenhum
    );
  }

  void _verificarCampos() {
    final preenchidos =
        _emailController.text.isNotEmpty &&
        _cpfController.text.isNotEmpty &&
        _nomeController.text.isNotEmpty &&
        _senhaController.text.isNotEmpty &&
        _plano.data != Plano.nenhum;
    setState(() => _todosPreenchidos = preenchidos);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _senhaController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.only(bottom: 10),
          child: SizedBox(
            width: 400,
            height: 570,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 14,
                  children: [
                    SelectableText(
                      'Cadastre-se',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: "Nome",
                        hintText: "Digite seu nome completo",
                      ),
                    ),
                    TextField(
                      controller: _cpfController,
                      decoration: const InputDecoration(
                        labelText: "CPF",
                        hintText: "999.999.999-99",
                      ),
                    ),
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
                    Row(
                      spacing: 14,
                      children: [
                        ...{
                          'Básico\n00,00R\$': Plano.basico,
                          'Intermediário\n00,00R\$': Plano.intermediario,
                          'Completo\n00,00R\$': Plano.completo,
                        }.entries.map((entry) {
                          return BotaoPlano(
                            text: entry.key,
                            controller: _plano,
                            plano: entry.value,
                          );
                        }),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsetsGeometry.only(top: 14, bottom: 6),
                      child: SizedBox(
                        width: 110,
                        height: 42,
                        child: Opacity(
                          opacity: _todosPreenchidos ? 1 : 0.8,
                          child: ElevatedButton(
                            onPressed: _todosPreenchidos
                                ? () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Campos preenchidos!'),
                                      ),
                                    );
                                  }
                                : null, // desativa o botão
                            child: const Text('Finalizar'),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.go('/');
                      },
                      splashColor: Colors.transparent, 
                      highlightColor: Colors.transparent, 
                      hoverColor: Colors.transparent,
                      child: Text.rich(
                        TextSpan(
                          text: 'Já é cadastrado? ',
                          style: Theme.of(context).textTheme.labelLarge,
                          children: [
                            TextSpan(
                              text: 'Faça login',
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
