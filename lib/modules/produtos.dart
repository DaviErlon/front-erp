import 'package:flutter/material.dart';
import 'package:fronterp/components/dialogs/upsert/upsert_produto.dart';
import 'package:fronterp/dtos/pagina_dto.dart';
import 'package:fronterp/dtos/produto_dto.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:fronterp/components/dialogs/filtros/filtro_dialog_produtos.dart';
import 'package:fronterp/components/botoeslinhas/linha_produto.dart';
import 'package:fronterp/services/ceo_service.dart';
import 'package:dio/dio.dart';

class ModuloProdutos extends StatefulWidget {
  const ModuloProdutos({super.key});

  @override
  State<ModuloProdutos> createState() => _ModuloProdutosState();
}

class _ModuloProdutosState extends State<ModuloProdutos> with LogoutMixin {
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
      final dados = await CeoService.getProdutos(
        nome: _buscaController.text,
        semEstoque: _filtrosProdutos.esgotado,
        comEstoquePendente: _filtrosProdutos.encomendado,
        comEstoqueReservado: _filtrosProdutos.reservado,
      );

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
  
  Future<void> _adicionarProduto(ProdutoDto dto) async {
    try {
      await CeoService.addProduto(dto);

      await _carregarProdutos();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Produto adicionado!')));
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
                padding: EdgeInsets.only(
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55),
                child: Row(
                  children: [
                    const Spacer(),
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
                    const Spacer(),
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: FloatingActionButton(
                        onPressed: () async {
                          final dadosProduto =
                              await showDialog<ProdutoDto>(
                                context: context,
                                builder: (_) => const UpsertProduto(),
                              );

                          if(dadosProduto != null) await _adicionarProduto(dadosProduto);
                        },
                        tooltip: 'Cadastrar Produto',
                        backgroundColor: Colors.green,
                        child: const Icon(
                          Icons.add,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 340,
                width: 970,
                child: _produtos == null
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(color: Colors.grey[500]),
                            child: Row(
                              spacing: 30,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 340,
                                  child: Center(
                                    child: Text(
                                      'Nome',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 140,
                                  child: Center(
                                    child: Text(
                                      'Preço',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      'Estoque Disponível',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      'Estoque Reservado',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      'Estoque Encomendado',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Scrollbar(
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
            ],
          ),
        ),
      ),
    );
  }
}
