import 'package:flutter/material.dart';
import 'package:fronterp/components/botao_sidebar.dart';
import 'package:fronterp/components/molde_tela.dart';
import 'package:fronterp/utils/utils.dart';

class CeoPage extends StatefulWidget {
  const CeoPage({super.key});

  @override
  State<CeoPage> createState() => _CeoPageState();
}

class _CeoPageState extends State<CeoPage> {
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
            'Títulos': Icons.receipt_long,
            'Funcionários': Icons.search,
            'Consultas': Icons.list_alt,
            'Logs': Icons.history_edu,
          }.entries.toList().asMap().entries.map((mapEntry) {
            final index = mapEntry.key;
            final chave = mapEntry.value.key;
            final icone = mapEntry.value.value;

            return BotaoSidebar(
              id: index,
              texto: chave,
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
