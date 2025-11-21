import 'package:flutter/material.dart';
import 'package:fronterp/components/botao_sidebar.dart';
import 'package:fronterp/components/molde_tela.dart';
import 'package:fronterp/modules/fornecedores.dart';
import 'package:fronterp/modules/logs.dart';
import 'package:fronterp/modules/produtos.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fronterp/modules/titulos.dart';
import 'package:fronterp/modules/funcionarios.dart';
import 'package:fronterp/modules/clientes.dart';

class CeoPage extends StatefulWidget {
  const CeoPage({super.key});

  @override
  State<CeoPage> createState() => _CeoPageState();
}

class _CeoPageState extends State<CeoPage> {
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
            'ceo.sidebar.titles': Icons.receipt_long,
            'ceo.sidebar.employees': Icons.search,
            'ceo.sidebar.queries': Icons.list_alt,
            'ceo.sidebar.logs': Icons.history_edu,
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
      body: IndexedStack(
        index: _modulo.data,
        children: [
          ModuloTitulos(),
          ModuloFuncionario(),
          ModuloClientesConsulta(),
          ModuloFornecedoresConsulta(),
          ModuloProdutosConsulta(),
          ModuloLogs(),
        ],
      ),
    );
  }
}
