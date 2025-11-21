import 'package:flutter/material.dart';
import 'package:fronterp/components/botao_sidebar.dart';
import 'package:fronterp/components/molde_tela.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';


class AlmoxarifePage extends StatefulWidget {
  const AlmoxarifePage({super.key});

  @override
  State<AlmoxarifePage> createState() => _AlmoxarifePageState();
}

class _AlmoxarifePageState extends State<AlmoxarifePage> {
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
            'almox.sidebar.titles': Icons.receipt_long,
            'almox.sidebar.products': Icons.inventory_2,
            'almox.sidebar.suppliers': Icons.factory
          }.entries.toList().asMap().entries.map((mapEntry) {
            final index = mapEntry.key;
            final chave = mapEntry.value.key;
            final icone = mapEntry.value.value;

            return BotaoSidebar(
              id: index,
              texto: chave.tr(),
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
