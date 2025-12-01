import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fronterp/components/botoes/botao_filtro.dart';
import 'package:fronterp/components/botoeslinhas/linha_funcionario.dart';
import 'package:fronterp/components/dialogs/filtros/filtro_dialog_funcionarios.dart';
import 'package:fronterp/dtos/funcionario_dto.dart';
import 'package:fronterp/dtos/pagina_dto.dart';
import 'package:fronterp/services/ceo_service.dart';
import 'package:fronterp/utils/utils.dart';

class ModuloFuncionario extends StatefulWidget {
  const ModuloFuncionario({super.key});

  @override
  State<ModuloFuncionario> createState() => _ModuloFuncionarioState();
}

class _ModuloFuncionarioState extends State<ModuloFuncionario>
    with LogoutMixin {
  late ControllerGenerico<Pesquisa> _tipoPesquisa;
  late TextEditingController _buscaController;
  Funcionario? _filtroTipoFuncionario;

  PaginaDto<FuncionarioDto>? _funcionarios;

  Future<void> _carregarFuncionarios() async {
    try {
      late PaginaDto<FuncionarioDto> dados;

      switch (_tipoPesquisa.data) {
        case Pesquisa.nome:
          dados = await CeoService.getFuncionarios(
            nome: _buscaController.text,
            tipo: _filtroTipoFuncionario?.name.toUpperCase(),
          );
          break;
        case Pesquisa.cpf:
          dados = await CeoService.getFuncionarios(
            cpf: _buscaController.text,
            tipo: _filtroTipoFuncionario?.name.toUpperCase(),
          );
          break;
        case Pesquisa.telefone:
          dados = await CeoService.getFuncionarios(
            telefone: _buscaController.text,
            tipo: _filtroTipoFuncionario?.name.toUpperCase(),
          );
          break;
        case _:
          break;
      }

      setState(() {
        _funcionarios = dados;
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
    _carregarFuncionarios();
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
                'Módulo de funcionários',
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
                          onSubmitted: (v) {
                            _filtroTipoFuncionario = null;
                            _carregarFuncionarios();
                          },
                          decoration: InputDecoration(
                            hintText: "Pesquise funcionários",
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
                          onPressed: () {
                            _filtroTipoFuncionario = null;
                            _carregarFuncionarios();
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
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      final filtros = await showDialog<Funcionario>(
                        context: context,
                        builder: (_) => const FiltrosDialogFuncionarios(),
                      );

                      setState(() {
                        _filtroTipoFuncionario = filtros;
                        _carregarFuncionarios();
                      });
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
                child: _funcionarios == null
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
                                  width: 80,
                                  child: Center(
                                    child: Text(
                                      'Cargo',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 360,
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
                                itemCount: _funcionarios!.dados.length,
                                itemBuilder: (context, index) {
                                  final funcionario =
                                      _funcionarios!.dados[index];
                                  return LinhaFuncionario(
                                    funcionario: funcionario,
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
