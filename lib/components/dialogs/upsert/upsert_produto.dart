import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fronterp/dtos/produto_dto.dart';

class UpsertProduto extends StatefulWidget {
  const UpsertProduto({super.key});

  @override
  State<UpsertProduto> createState() => _UpsertProdutoState();
}

class _UpsertProdutoState extends State<UpsertProduto> {
  late TextEditingController _nomeController;
  late TextEditingController _precoController;
  late TextEditingController _qtdController;

  bool _podeAdicionar = false;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _precoController = TextEditingController();
    _qtdController = TextEditingController();

    _nomeController.addListener(_verificarCampos);
    _precoController.addListener(_verificarCampos);
    _qtdController.addListener(_verificarCampos);
  }

  void _verificarCampos() {
    bool nomeValido =
        _nomeController.text.length > 3 && _nomeController.text.length < 100;

    bool precoValido =
        double.tryParse(_precoController.text) != null &&
        double.parse(_precoController.text) > 0.00;

    bool qtdValida = int.tryParse(_qtdController.text) != null;

    setState(() {
      _podeAdicionar = nomeValido && precoValido && qtdValida;
    });
  }

  @override
  void dispose() {
    _nomeController.removeListener(_verificarCampos);
    _precoController.removeListener(_verificarCampos);
    _qtdController.removeListener(_verificarCampos);

    _nomeController.dispose();
    _precoController.dispose();
    _qtdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Cadastrar Produto',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome do produto",
                  border: UnderlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: _precoController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  PriceFormatter(),
                ],
                decoration: const InputDecoration(
                  labelText: "Preço",
                  border: UnderlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: _qtdController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: "Quantidade",
                  border: UnderlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: 140,
                height: 42,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(
                      Colors.deepPurple,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  onPressed: _podeAdicionar
                      ? () {
                          Navigator.pop(
                            context,
                            ProdutoDto(
                              nome: _nomeController.text,
                              preco: double.tryParse(_precoController.text) ?? 0.1,
                              quantidade: int.tryParse(_qtdController.text) ?? 0,
                            ),
                          );
                        }
                      : null,
                  child: const Text("Adicionar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PriceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    String digits = newValue.text;

    digits = digits.replaceFirst(RegExp(r'^0+'), '');
    if (digits.length < 3) {
      digits = digits.padLeft(3, '0');
    }

    String value =
        "${digits.substring(0, digits.length - 2)}.${digits.substring(digits.length - 2)}";

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }
}
