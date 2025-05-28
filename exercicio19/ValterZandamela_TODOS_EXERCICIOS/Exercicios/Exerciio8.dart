import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(AppDuasTelas());
}

class AppDuasTelas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio 8',
      initialRoute: '/', // Define a rota inicial
      routes: {
        '/': (context) => TelaSalvarNome(),
        '/saudacao': (context) => TelaSaudacao(),
      },
    );
  }
}

// --- Tela 1: Salvar Nome ---
class TelaSalvarNome extends StatefulWidget {
  @override
  _TelaSalvarNomeState createState() => _TelaSalvarNomeState();
}

class _TelaSalvarNomeState extends State<TelaSalvarNome> {
  final TextEditingController _nomeController = TextEditingController();

  Future<void> _salvarNomeEIrParaSaudacao(String nome) async {
    if (nome.isEmpty) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome_app_duas_telas', nome);
    // Navega para a segunda tela
    Navigator.pushNamed(context, '/saudacao');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Save Name')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Digite seu nome', border: OutlineInputBorder(),),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _salvarNomeEIrParaSaudacao(_nomeController.text),
              child: Text('Salvar e Ver Saudação'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Tela 2: Exibir Saudação ---
class TelaSaudacao extends StatefulWidget {
  @override
  _TelaSaudacaoState createState() => _TelaSaudacaoState();
}

class _TelaSaudacaoState extends State<TelaSaudacao> {
  String _mensagemSaudacao = "A carregar nome...";

  @override
  void initState() {
    super.initState();
    _carregarNome();
  }

  Future<void> _carregarNome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nome = prefs.getString('nome_app_duas_telas');
    setState(() {
      if (nome != null && nome.isNotEmpty) {
        _mensagemSaudacao = "Olá, $nome!";
      } else {
        _mensagemSaudacao = "Olá! Nome não encontrado.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saudação')),
      body: Center(
        child: Text(
          _mensagemSaudacao,
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        tooltip: 'Voltar',
      ),
    );
  }
}