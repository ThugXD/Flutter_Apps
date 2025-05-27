import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Produto {
  String nome;
  String descricao;
  String imagem;

  Produto({
    required this.nome,
    required this.descricao,
    required this.imagem,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista Produtos',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const ProdutoPage(),
    );
  }
}

class ProdutoPage extends StatefulWidget {
  const ProdutoPage({super.key});

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  final List<Produto> _produtos = [];

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _imagemController = TextEditingController();

  void _adicionarProduto() {
    final nome = _nomeController.text.trim().toUpperCase();
    final descricao = _descricaoController.text.trim();
    final imagem = _imagemController.text.trim();

    if (nome.isEmpty || descricao.isEmpty || imagem.isEmpty) return;

    setState(() {
      _produtos.add(Produto(
        nome: nome,
        descricao: descricao,
        imagem: imagem,
      ));
    });

    _nomeController.clear();
    _descricaoController.clear();
    _imagemController.clear();
  }

  void _removerProduto(int index) {
    setState(() {
      _produtos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista Produtos')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _imagemController,
              decoration: const InputDecoration(
                  labelText: 'Imagem (ex: assets/banana.png)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _adicionarProduto,
              child: const Text('Adicionar Produto'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _produtos.length,
                itemBuilder: (context, index) {
                  final produto = _produtos[index];
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        produto.imagem,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      title: Text(produto.nome),
                      subtitle: Text(produto.descricao),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removerProduto(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
