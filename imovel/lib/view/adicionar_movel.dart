import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:fluttertoast/fluttertoast.dart';


import '../model/Novo.dart';
import '../model/Velho.dart';
import '../modelview/ImovelViewModel.dart';

class AdicionarImovelPage extends StatefulWidget {
  @override
  _AdicionarImovelPageState createState() => _AdicionarImovelPageState();
}

class _AdicionarImovelPageState extends State<AdicionarImovelPage> {
  final enderecoController = TextEditingController();
  final precoController = TextEditingController();
  final extraController = TextEditingController();
  String tipo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Cadastrar Imóvel'),
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(enderecoController, 'Endereço'),
            SizedBox(height: 20),
            _buildTextField(precoController, 'Preço', isNumber: true),
            SizedBox(height: 20),
            Text(
              'Tipo do Imóvel',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                    value: tipo == 'Novo',
                    onChanged: (_) {
                      setState(() {
                        tipo = 'Novo';
                      });
                    }),
                Text('Novo'),
                SizedBox(width: 20),
                Checkbox(
                    value: tipo == 'Velho',
                    onChanged: (_) {
                      setState(() {
                        tipo = 'Velho';
                      });
                    }),
                Text('Velho'),
              ],
            ),
            if (tipo == 'Novo' || tipo == 'Velho') ...[
              SizedBox(height: 20),
              _buildTextField(
                extraController,
                tipo == 'Novo' ? 'Adicional no preço' : 'Desconto no preço',
                isNumber: true,
              ),
            ],
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _salvarImovel,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 18),
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Salvar Imóvel',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  void _salvarImovel() {
    final endereco = enderecoController.text;
    final preco = double.tryParse(precoController.text) ?? 0;
    final extra = double.tryParse(extraController.text) ?? 0;

    if (tipo == 'Novo') {
      Provider.of<ImovelViewModel>(context, listen: false)
          .adicionarImovel(Novo(endereco: endereco, preco: preco, adicional: extra));
    } else if (tipo == 'Velho') {
      Provider.of<ImovelViewModel>(context, listen: false)
          .adicionarImovel(Velho(endereco: endereco, preco: preco, desconto: extra));
    }
    Navigator.pop(context);
  }
}
