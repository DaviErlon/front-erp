import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fronterp/components/botoes/botao_filtro.dart';
import 'package:fronterp/components/botoeslinhas/linha_cliente.dart';
import 'package:fronterp/dtos/cliente_dto.dart';
import 'package:fronterp/dtos/pagina_dto.dart';
import 'package:fronterp/services/ceo_service.dart';
import 'package:fronterp/utils/utils.dart';

class ModuloClientes extends StatefulWidget {
  const ModuloClientes({super.key});

  @override
  State<ModuloClientes> createState() => _ModuloClientesState();
}

class _ModuloClientesState extends State<ModuloClientes> with LogoutMixin {
  late ControllerGenerico<Pesquisa> _tipoPesquisa;
  PaginaDto<ClienteDto>? _clientes;
  late TextEditingController _buscaController;

  Future<void> _carregarClientes() async {
    try {
      late PaginaDto<ClienteDto> dados;

      switch (_tipoPesquisa.data) {
        case Pesquisa.nome:
          dados = await CeoService.getClientes(nome: _buscaController.text);
          break;
        case Pesquisa.cpf:
          dados = await CeoService.getClientes(cpf: _buscaController.text);
          break;
        case Pesquisa.telefone:
          dados = await CeoService.getClientes(telefone: _buscaController.text);
          break;
        case _:
          break;
      }

      setState(() {
        _clientes = dados;
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
    _carregarClientes();
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
                'Módulo de clientes',
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
                            await _carregarClientes();
                          },
                          decoration: InputDecoration(
                            hintText: "Pesquise clientes",
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
                            await _carregarClientes();
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
                child: _clientes == null
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
                                      'Cpf',
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
                              child: ListView.builder(
                                itemCount: _clientes!.dados.length,
                                itemBuilder: (context, index) {
                                  final cliente = _clientes!.dados[index];
                                  return LinhaCliente(
                                    cliente: cliente,
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
