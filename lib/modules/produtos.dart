import 'package:flutter/material.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:fronterp/components/filtro_dialog_produtos.dart';

class ModuloProdutosConsulta extends StatefulWidget {
  const ModuloProdutosConsulta({super.key});

  @override
  State<ModuloProdutosConsulta> createState() => _ModuloProdutosConsultaState();
}

class _ModuloProdutosConsultaState extends State<ModuloProdutosConsulta> {
  late ControllerDialogProdutos _filtrosProdutos;

  @override
  void initState() {
    super.initState();
    _filtrosProdutos = ControllerDialogProdutos();
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
                'Módulo de produtos',
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
                            hintText: "Pesquise produtos",
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
                children: [
                  InkWell(
                    onTap: () async {
                      final filtros = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (_) => const FiltrosDialogProdutos(),
                      );

                      if (filtros != null) {
                        setState(() {
                          _filtrosProdutos.updateFromMap(filtros);
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
            ],
          ),
        ),
      ),
    );
  }
}
