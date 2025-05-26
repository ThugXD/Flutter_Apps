import 'package:flutter/material.dart';

class AdicionarImovelPage extends StatefulWidget{
  @override
  _AdicinarImovelPageState createState() =>_AdicinarImovelPageState();
}

class _AdicinarImovelPageState extends State<AdicionarImovelPage> {
  final nomeImovelController = TextEditingController();
  final precoController = TextEditingController();
  final extraController = TextEditingController();
  String tipo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Cadastro'),
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
            _buildTextField(nomeImovelController, 'Nome Imovel'),
            SizedBox(height: 20),
            _buildTextField(precoController, 'Preço'),

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
           borderRadius: BorderRadius.circular(15),
         ),
         filled: true,
         fillColor: Colors.white,
         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
       ),
     );
  }

  void _salvarImovel() {
    final nomeImovel = nomeImovelController.text;
    final preco = double.tryParse(precoController.text ) ?? 0;
    final extra = double.tryParse(extraController.text) ?? 0;


  }
}