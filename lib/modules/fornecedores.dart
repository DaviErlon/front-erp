import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fronterp/components/botoes/botao_filtro.dart';
import 'package:fronterp/components/botoeslinhas/linha_fornecedor.dart';
import 'package:fronterp/dtos/fornecedor_dto.dart';
import 'package:fronterp/dtos/pagina_dto.dart';
import 'package:fronterp/services/ceo_service.dart';
import 'package:fronterp/utils/utils.dart';

class ModuloFornecedores extends StatefulWidget {
  const ModuloFornecedores({super.key});

  @override
  State<ModuloFornecedores> createState() => _ModuloFornecedoresState();
}

class _ModuloFornecedoresState extends State<ModuloFornecedores>
    with LogoutMixin {
  late ControllerGenerico<Pesquisa> _tipoPesquisa;
  late TextEditingController _buscaController;

  PaginaDto<FornecedorDto>? _fornecedores;

  Future<void> _carregarFornecedores() async {
    try {
      late PaginaDto<FornecedorDto> dados;

      switch (_tipoPesquisa.data) {
        case Pesquisa.nome:
          dados = await CeoService.getFornecedores(nome: _buscaController.text);
          break;
        case Pesquisa.cpf:
          dados = await CeoService.getFornecedores(cpf: _buscaController.text);
          break;
        case Pesquisa.cnpj:
          dados = await CeoService.getFornecedores(cnpj: _buscaController.text);
          break;
        case Pesquisa.telefone:
          dados = await CeoService.getFornecedores(
            telefone: _buscaController.text,
          );
          break;
      }

      setState(() {
        _fornecedores = dados;
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
  void initState() {
    super.initState();
    _tipoPesquisa = ControllerGenerico(
      onPressed: () {
        setState(() {});
      },
      data: Pesquisa.nome,
    );
    _buscaController = TextEditingController();
    _carregarFornecedores();
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
                'Módulo de fornecedores',
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
                            await _carregarFornecedores();
                          },
                          decoration: InputDecoration(
                            hintText: "Pesquise fornecedores",
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
                            await _carregarFornecedores();
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
                spacing: 30,
                children: [
                  Icon(Icons.manage_search, size: 30, color: Colors.deepPurple),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 40,
                    children: [
                      ...{
                        'cpf': Pesquisa.cpf,
                        'cnpj': Pesquisa.cnpj,
                        'nome': Pesquisa.nome,
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
                ],
              ),

              const SizedBox(height: 20),
              SizedBox(
                height: 340,
                width: 970,
                child: _fornecedores == null
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
                                  width: 440,
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
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      'Cpf/Cnpj',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      'Telefone',
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
                              child: Scrollbar(
                                thumbVisibility: true,
                                child: ListView.builder(
                                  itemCount: _fornecedores!.dados.length,
                                  itemBuilder: (context, index) {
                                    final fornecedor =
                                        _fornecedores!.dados[index];
                                    return LinhaFornecedor(
                                      fornecedor: fornecedor,
                                      isEven: index % 2 == 0,
                                      onTap: () {},
                                    );
                                  },
                                ),
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
