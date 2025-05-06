import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Novo.dart';
import '../model/Velho.dart';
import '../modelview/ImovelViewModel.dart';
import 'adicionar_movel.dart'; // 👈 Certifique-se que o nome está correto!

class ListarImoveisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ImovelViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Imóveis'),
        backgroundColor: Colors.indigo,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: viewModel.filtro,
                items: ['Todos', 'Novo', 'Velho']
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (val) => viewModel.setFiltro(val!),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.imoveis.length,
              itemBuilder: (context, index) {
                final imovel = viewModel.imoveis[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text(imovel.endereco),
                    subtitle: Text(
                      imovel is Novo
                          ? 'Preço: R\$${imovel.getPrecoFinal()} (${imovel.getInfoAdicional()})'
                          : imovel is Velho
                          ? 'Preço: R\$${imovel.getPrecoFinal()} (${imovel.getInfoDesconto()})'
                          : 'Preço: R\$${imovel.preco}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            // TODO: Implementar funcionalidade de editar
                            // Pode navegar para a tela de editar passando os dados do imóvel
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => viewModel.removerImovel(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AdicionarImovelPage()),
          );
        },
      ),
    );
  }
}
