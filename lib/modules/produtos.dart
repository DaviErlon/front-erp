import 'package:flutter/material.dart';
import 'package:fronterp/dtos/pagina_dto.dart';
import 'package:fronterp/dtos/produto_dto.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:fronterp/components/filtrosdialog/filtro_dialog_produtos.dart';
import 'package:fronterp/components/botoeslinhas/linha_produto.dart';
import 'package:fronterp/services/ceo_service.dart';
import 'package:dio/dio.dart';

class ModuloProdutos extends StatefulWidget {
  const ModuloProdutos({super.key});

  @override
  State<ModuloProdutos> createState() => _ModuloProdutosState();
}

class _ModuloProdutosState extends State<ModuloProdutos>
    with LogoutMixin {
  late ControllerDialogProdutos _filtrosProdutos;
  PaginaDto<ProdutoDto>? _produtos;
  late TextEditingController _buscaController;

  @override
  void initState() {
    super.initState();
    _buscaController = TextEditingController();
    _filtrosProdutos = ControllerDialogProdutos();

    _carregarProdutos();
  }

  Future<void> _carregarProdutos() async {
    try {
      final dados = await CeoService.getProdutos(nome: _buscaController.text, semEstoque: _filtrosProdutos.esgotado, comEstoquePendente: _filtrosProdutos.encomendado, comEstoqueReservado: _filtrosProdutos.reservado);

      setState(() {
        _produtos = dados;
      });
    } on DioException catch (dioErr, _) {
      doLogout(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Token expirado!')));
    } catch (err) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro de conexão com o servidor')));
    }
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
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
                          controller: _buscaController,
                          onSubmitted: (v) async {
                            _filtrosProdutos.clear();
                            await _carregarProdutos();
                          },
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
                          onPressed: () async {
                            _filtrosProdutos.clear();
                            await _carregarProdutos();
                          },
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
                        _filtrosProdutos.updateFromMap(filtros);
                        await _carregarProdutos();
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
              const SizedBox(height: 20),
              SizedBox(
                height: 340,
                width: 970,
                child: _produtos == null
                    ? const Center(child: CircularProgressIndicator())
                    : Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          itemCount: _produtos!.dados.length,
                          itemBuilder: (context, index) {
                            final produto = _produtos!.dados[index];
                            return LinhaProduto(
                              produto: produto,
                              isEven: index % 2 == 0,
                              onTap: () {},
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
