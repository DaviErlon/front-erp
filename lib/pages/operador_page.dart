import 'package:flutter/material.dart';
import 'package:fronterp/components/botao_sidebar.dart';
import 'package:fronterp/components/molde_tela.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class OperadorPage extends StatefulWidget {
  const OperadorPage({super.key});

  @override
  State<OperadorPage> createState() => _OperadorPageState();
}

class _OperadorPageState extends State<OperadorPage> {
  late ModuloSelecionado _modulo;

  @override
  void initState() {
    super.initState();
    _modulo = ModuloSelecionado(
      onPressed: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MoldeTela(
      sideBar: Column(
        children: [
          ...{
            'operador.sidebar.sell': Icons.shopping_cart,
            'operador.sidebar.products': Icons.inventory,
            'operador.sidebar.clients': Icons.person_2_outlined,
            'operador.sidebar.sales': Icons.app_registration,
          }.entries.toList().asMap().entries.map((mapEntry) {
            final index = mapEntry.key;
            final chave = mapEntry.value.key;
            final icone = mapEntry.value.value;

            return BotaoSidebar(
              id: index,
              texto: chave.tr(),
              icone: icone,
              moduloSelecionado: _modulo,
            );
          }),
        ],
      ),
      body: Center(),
    );
  }
}
