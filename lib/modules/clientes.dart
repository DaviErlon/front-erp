import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fronterp/components/botao_filtro.dart';
import 'package:fronterp/components/linha_cliente.dart';
import 'package:fronterp/dtos/cliente_dto.dart';
import 'package:fronterp/dtos/pagina_dto.dart';
import 'package:fronterp/services/ceo_service.dart';
import 'package:fronterp/services/data_storage.dart';
import 'package:fronterp/utils/utils.dart';

class ModuloClientes extends StatefulWidget {
  const ModuloClientes({super.key});

  @override
  State<ModuloClientes> createState() => _ModuloClientesState();
}

class _ModuloClientesState extends State<ModuloClientes> with LogoutMixin {
  late ControllerGenerico<Pesquisa> _tipoPesquisa;
  PaginaDto<ClienteDto>? _clientes;

  Future<void> _carregarClientes() async {
    try {
      await DataStorage.carregarToken();
      final dados = await CeoService.getClientes();

      setState(() {
        _clientes = dados;
      });
    } on DioException catch (dioErr, _) {
      doLogout(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Token expirado!')));
    } catch (err, _) {
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
    _carregarClientes();
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
                          onSubmitted: (v) {},
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
                    : Scrollbar(
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
      ),
    );
  }
}
