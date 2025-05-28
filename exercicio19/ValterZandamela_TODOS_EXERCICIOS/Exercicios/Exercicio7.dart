
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences',
      home: PreferenciaScreen(),
    );
  }
}

class PreferenciaScreen extends StatefulWidget {
  @override
  _PreferenciasScreenState createState() => _PreferenciasScreenState();
}

class _PreferenciasScreenState extends State<PreferenciaScreen> {
  final TextEditingController _nomeController = TextEditingController();
  String _nomeSalvo = "Nenhum nome salvo";

  Future<void> _salvarNome(String nome) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome_utilizador_ui', nome);

    setState(() {
      _nomeSalvo = "Nome '$nome' salvo!";
    });
      _nomeController.clear();
  }
  Future<void> _lerNome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nome = prefs.getString('nome_utlizador_ui');
    setState(() {
      if(nome != null && nome.isNotEmpty) {
        _nomeSalvo = "Nome lido: $nome";
      } else {
        _nomeSalvo = "Nenhum nome enontrado.";
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lerNome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercicio 7'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Digita o nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
                height: 20
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_nomeController.text.isNotEmpty) {
                      _salvarNome(_nomeController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text('Salvar Nome'),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _lerNome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text('Ler Nome'),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
                _nomeSalvo,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}

