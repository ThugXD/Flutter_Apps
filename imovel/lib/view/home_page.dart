import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adicionar_movel.dart';
import 'imovel_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thug Imóveis'),
        centerTitle: false,
        backgroundColor: Colors.indigo,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _styledButton(
                context,
                label: 'Adicionar Imóvel',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AdicionarImovelPage()),
                ),
                textColor: Colors.white,
              ),
              SizedBox(height: 30),
              _styledButton(
                context,
                label: 'Listar Imóveis',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ListarImoveisPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Estilo do Botão
  Widget _styledButton(BuildContext context,
      {
        required String label,
        required VoidCallback onPressed,
        Color textColor = Colors.white}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18),
          backgroundColor: Colors.indigo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          elevation: 6,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
      ),
    );
  }
}
