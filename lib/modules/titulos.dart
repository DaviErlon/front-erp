import 'package:flutter/material.dart';
import 'package:fronterp/components/botao_filtro.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:fronterp/components/filtro_dialog_titulos.dart';

class ModuloTitulos extends StatefulWidget {
  const ModuloTitulos({super.key});

  @override
  State<ModuloTitulos> createState() => _ModuloTitulosState();
}

class _ModuloTitulosState extends State<ModuloTitulos> {
  late ControllerGenerico<Pesquisa> _tipoPesquisa;
  late ControllerDialogTitulos _filtroTitulos;

  @override
  void initState() {
    super.initState();
    _tipoPesquisa = ControllerGenerico(
      onPressed: () {
        setState(() {});
      },
      data: Pesquisa.nome,
    );
    _filtroTitulos = ControllerDialogTitulos();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1040,
        height: 580,
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 15),
              SelectableText(
                'Módulo de títulos',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 10,
                  bottom: 20,
                  left: 30,
                  right: 30,
                ),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onSubmitted: (v) {},
                          decoration: InputDecoration(
                            hintText: "Pesquise títulos",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(8),
                              ),
                              borderSide: BorderSide(color: Colors.black38),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(8),
                              ),
                            ),
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 30,
                children: [
                  Icon(Icons.manage_search, size: 30, color: Colors.deepPurple),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 40,
                    children: [
                      ...{
                        'cpf': Pesquisa.cpf,
                        'nome': Pesquisa.nome,
                        'cnpj': Pesquisa.cpnj,
                        'telefone': Pesquisa.telefone,
                      }.entries.map((entry) {
                        return BotaoFiltro(
                          controller: _tipoPesquisa,
                          texto: entry.key,
                          filtro: entry.value,
                        );
                      }),
                    ],
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      final filtros = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (_) => const FiltrosDialogTitulos(),
                      );

                      if (filtros != null) {
                        setState((){
                          _filtroTitulos.updateFromMap(filtros);
                        });
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.filter_alt_outlined,
                          size: 26,
                          color: Colors.deepPurple,
                        ),
                        Text(
                          'filtros',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 340,
                width: 970,
                child: Container(
                  color: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
