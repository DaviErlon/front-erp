import 'package:flutter/material.dart';
import 'package:fronterp/components/botao_sidebar.dart';
import 'package:fronterp/components/molde_tela.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class GestorPage extends StatefulWidget {
  const GestorPage({super.key});

  @override
  State<GestorPage> createState() => _GestorPageState();
}

class _GestorPageState extends State<GestorPage> {
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
            'gestor.sidebar.titles': Icons.receipt_long,
            'gestor.sidebar.employees': Icons.search,
            'gestor.sidebar.queries': Icons.list_alt,
            'gestor.sidebar.logs': Icons.history_edu,
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
