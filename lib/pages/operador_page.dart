import 'package:flutter/material.dart';
import 'package:fronterp/components/botao_sidebar.dart';
import 'package:fronterp/components/molde_tela.dart';
import 'package:fronterp/utils/utils.dart';

class OperadorPage extends StatefulWidget {
  const OperadorPage({super.key});

  @override
  State<OperadorPage> createState() => _OperadorPageState();
}

class _OperadorPageState extends State<OperadorPage> {
  late ControllerGenerico<int> _modulo;

  @override
  void initState() {
    super.initState();
    _modulo = ControllerGenerico(
      onPressed: () {
        setState(() {});
      },
      data: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MoldeTela( 
      sideBar: Column(
        children: [
          ...{
            'VENDER': Icons.shopping_cart,
            'PRODUTOS': Icons.inventory,
            'CLIENTES': Icons.person_2_outlined,
            'VENDAS': Icons.app_registration,
          }.entries.toList().asMap().entries.map((mapEntry) {
            final index = mapEntry.key;
            final chave = mapEntry.value.key;
            final icone = mapEntry.value.value;

            return BotaoSidebar(
              id: index,
              texto: chave,
              icone: icone,
              controller: _modulo,
            );
          }),
        ],
      ),
      body: Center(),
    );
  }
}
