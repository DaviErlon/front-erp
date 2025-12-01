import 'package:flutter/material.dart';
import 'package:fronterp/components/botoes/botao_filtro.dart';
import 'package:fronterp/dtos/pagina_dto.dart';
import 'package:fronterp/dtos/titulo_dto.dart';
import 'package:fronterp/services/ceo_service.dart';
import 'package:fronterp/utils/utils.dart';
import 'package:fronterp/components/dialogs/filtros/filtro_dialog_titulos.dart';
import 'package:fronterp/components/botoeslinhas/linha_titulo.dart';
import 'package:dio/dio.dart';

class ModuloTitulos extends StatefulWidget {
  const ModuloTitulos({super.key});

  @override
  State<ModuloTitulos> createState() => _ModuloTitulosState();
}

class _ModuloTitulosState extends State<ModuloTitulos> with LogoutMixin {
  late ControllerGenerico<Pesquisa> _tipoPesquisa;
  late ControllerDialogTitulos _filtroTitulos;
  late TextEditingController _buscaController;
  PaginaDto<TituloDto>? _titulos;

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
    _buscaController = TextEditingController();
    _carregarTitulos();
  }

  Future<void> _carregarTitulos() async {
    try {
      late PaginaDto<TituloDto> dados;

      switch (_tipoPesquisa.data) {
        case Pesquisa.nome:
          dados = await CeoService.getTitulos(
            nome: _buscaController.text,
            pago: _filtroTitulos.pago,
            recebido: _filtroTitulos.recebido,
            aprovado: _filtroTitulos.aprovado,
          );
          break;
        case Pesquisa.cpf:
          dados = await CeoService.getTitulos(
            cpf: _buscaController.text,
            pago: _filtroTitulos.pago,
            recebido: _filtroTitulos.recebido,
            aprovado: _filtroTitulos.aprovado,
          );
          break;
        case Pesquisa.cnpj:
          dados = await CeoService.getTitulos(
            cnpj: _buscaController.text,
            pago: _filtroTitulos.pago,
            recebido: _filtroTitulos.recebido,
            aprovado: _filtroTitulos.aprovado,
          );
          break;
        case Pesquisa.telefone:
          dados = await CeoService.getTitulos(
            telefone: _buscaController.text,
            pago: _filtroTitulos.pago,
            recebido: _filtroTitulos.recebido,
            aprovado: _filtroTitulos.aprovado,
          );
          break;
      }

      setState(() {
        _titulos = dados;
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
                          controller: _buscaController,
                          onSubmitted: (v) async {
                            _filtroTitulos.clear();
                            await _carregarTitulos();
                          },
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
                          onPressed: () async {
                            _filtroTitulos.clear();
                            await _carregarTitulos();
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
                        'cnpj': Pesquisa.cnpj,
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
                        _filtroTitulos.updateFromMap(filtros);
                        await _carregarTitulos();
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
                child: _titulos == null
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
                                  width: 240,
                                  child: Center(
                                    child: Text(
                                      'Nome do titular',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 140,
                                  child: Center(
                                    child: Text(
                                      'Cpf/Cnpj',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: Center(
                                    child: Text(
                                      'Valor',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      'Data',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                                itemCount: _titulos!.dados.length,
                                itemBuilder: (context, index) {
                                  final titulo = _titulos!.dados[index];
                                  return LinhaTitulo(
                                    titulo: titulo,
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
