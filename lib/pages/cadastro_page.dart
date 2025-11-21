  import 'package:flutter/material.dart';
  import 'package:go_router/go_router.dart';
  import 'package:fronterp/components/botao_plano.dart';
  import 'package:fronterp/utils/utils.dart';
  import 'package:easy_localization/easy_localization.dart';


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
    final TipoPlano _plano = TipoPlano();
    final SenhaOculta _senhaOculta = SenhaOculta();

    bool _todosPreenchidos = false;

    @override
    void initState() {
      super.initState();
      _nomeController.addListener(_verificarCampos);
      _senhaController.addListener(_verificarCampos);
      _emailController.addListener(_verificarCampos);
      _cpfController.addListener(_verificarCampos);
    }

    void _verificarCampos() {
      final preenchidos =
          _emailController.text.isNotEmpty &&
          _cpfController.text.isNotEmpty &&
          _nomeController.text.isNotEmpty &&
          _senhaController.text.isNotEmpty;
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
                        'auth.signup.title'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                          labelText: 'auth.signup.name_label'.tr(),
                          hintText: "Digite seu nome completo",
                        ),
                      ),
                      TextField(
                        controller: _cpfController,
                        decoration: InputDecoration(
                          labelText: 'auth.signup.cpf_label'.tr(),
                          hintText: 'auth.signup.cpf_hint'.tr(),
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'auth.signup.email_label'.tr(),
                          hintText: 'auth.signup.email_hint'.tr(),
                        ),
                      ),
                      TextField(
                        controller: _senhaController,
                        obscureText: !_senhaOculta.visivel,
                        decoration: InputDecoration(
                          labelText: 'auth.signup.password_label'.tr(),
                          hintText: 'auth.signup.password_hint'.tr(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _senhaOculta.visivel
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.deepPurple.shade400,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                _senhaOculta.alternar();
                              });
                            },
                          ),
                        ),
                      ),
                      Row(
                        spacing: 14,
                        children: [
                          BotaoPlano(
                            text: 'auth.signup.plan_basic'.tr(),
                            onPressed: () {
                              setState(() {
                                _plano.altplano = Plano.basico;
                              });
                            },
                            filled: _plano.plano == Plano.basico,
                          ),
                          BotaoPlano(
                            text: 'auth.signup.plan_intermediate'.tr(),
                            onPressed: () {
                              setState(() {
                                _plano.altplano = Plano.intermediario;
                              });
                            },
                            filled: _plano.plano == Plano.intermediario,
                          ),
                          BotaoPlano(
                            text: 'Completo\n00,00R\$',
                            onPressed: () {
                              setState(() {
                                _plano.altplano = Plano.completo;
                              });
                            },
                            filled: _plano.plano == Plano.completo,
                          ),
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
                                        SnackBar(
                                          content: Text('auth.signup.snackbar_all_filled'.tr())
                                        ),
                                      );
                                    }
                                  : null, // desativa o botão
                              child: Text('auth.signup.submit'.tr())
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.go('/');
                        },
                        splashColor: Colors.transparent, // sem efeito de clique
                        highlightColor:
                            Colors.transparent, // sem efeito de clique
                        hoverColor: Colors.transparent, // sem efeito de hover
                        child: Text.rich(
                          TextSpan(
                            text: 'auth.signup.already_registered'.tr(),
                            style: Theme.of(context).textTheme.labelLarge,
                            children: [
                              TextSpan(
                                text: 'auth.signup.login'.tr(),
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
