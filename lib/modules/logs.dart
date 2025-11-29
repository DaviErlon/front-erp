import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fronterp/components/botoes/botao_filtro.dart';
import 'package:fronterp/components/botoeslinhas/linha_log.dart';
import 'package:fronterp/components/filtrosdialog/filtro_log.dart';
import 'package:fronterp/dtos/log_auditoria_dto.dart';
import 'package:fronterp/dtos/pagina_dto.dart';
import 'package:fronterp/services/ceo_service.dart';
import 'package:fronterp/utils/utils.dart';

class ModuloLogs extends StatefulWidget {
  const ModuloLogs({super.key});

  @override
  State<ModuloLogs> createState() => _ModuloLogsState();
}

class _ModuloLogsState extends State<ModuloLogs> with LogoutMixin {
  late ControllerGenerico<Pesquisa> _tipoPesquisa;
  late TextEditingController _buscaController;

  DateTime? _data;

  PaginaDto<LogAuditoriaDto>? _logs;

  Future<void> _carregarLogs() async {
    try {
      late PaginaDto<LogAuditoriaDto> dados;

      switch (_tipoPesquisa.data) {
        case Pesquisa.nome:
          dados = await CeoService.getLogs(
            nome: _buscaController.text,
            inicio: _data,
            fim: _data != null ? _fimDoDia(_data!) : null,
          );
          break;
        case Pesquisa.cpf:
          dados = await CeoService.getLogs(
            cpf: _buscaController.text,
            inicio: _data,
            fim: _data != null ? _fimDoDia(_data!) : null,
          );
          break;
        case Pesquisa.telefone:
          dados = await CeoService.getLogs(
            telefone: _buscaController.text,
            inicio: _data,
            fim: _data != null ? _fimDoDia(_data!) : null,
          );
          break;
        case _:
          break;
      }

      setState(() {
        _logs = dados;
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
    _buscaController = TextEditingController();
    _tipoPesquisa = ControllerGenerico(
      onPressed: () {
        setState(() {});
      },
      data: Pesquisa.nome,
    );
    _carregarLogs();
  }

  DateTime _fimDoDia(DateTime x) {
    return DateTime(x.year, x.month, x.day, 23, 59, 59, 999);
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
                'Módulo de logs',
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
                            _data = null; 
                            await _carregarLogs();
                          },
                          decoration: InputDecoration(
                            hintText: "Pesquise Logs",
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
                            _data = null;
                            await _carregarLogs();
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
                      final filtros = await showDialog<DateTime>(
                        context: context,
                        builder: (_) => const FiltroLog(),
                      );
                      if (filtros != null) {
                        _data = filtros;
                        await _carregarLogs();
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
                child: _logs == null
                    ? const Center(child: CircularProgressIndicator())
                    : Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          itemCount: _logs!.dados.length,
                          itemBuilder: (context, index) {
                            final log = _logs!.dados[index];
                            return LinhaLog(
                              log: log,
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
