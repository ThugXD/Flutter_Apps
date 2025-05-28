import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io'; // Para File e Directory

void main() {
  runApp(AppFormularioFicheiro());
}

class AppFormularioFicheiro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário',
      home: TelaFormulario(),
    );
  }
}

class TelaFormulario extends StatefulWidget {
  @override
  _TelaFormularioState createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mensagemController = TextEditingController();

  String _feedbackMensagem = '';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/dados_formulario.txt');
  }

  Future<void> _salvarDados() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String dados = "Nome: ${_nomeController.text}\n"
          "Email: ${_emailController.text}\n"
          "Mensagem: ${_mensagemController.text}\n"
          "-----------------------------------\n";

      try {
        final file = await _localFile;
        // Escreve no ficheiro, adicionando ao conteúdo existente (modo append)
        await file.writeAsString(dados, mode: FileMode.append);
        setState(() {
          _feedbackMensagem = 'Dados salvos com sucesso em: ${file.path}';
        });
        // Limpar os campos após salvar
        _nomeController.clear();
        _emailController.clear();
        _mensagemController.clear();
      } catch (e) {
        setState(() {
          _feedbackMensagem = 'Erro ao salvar dados: $e';
        });
      }
    }
  }

  Future<String> _lerDados() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String contents = await file.readAsString();
        return contents;
      }
      return "Ficheiro não encontrado ou vazio.";
    } catch (e) {
      return "Erro ao ler ficheiro: $e";
    }
  }

  void _mostrarDadosLidos() async {
    String dados = await _lerDados();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Conteúdo do Ficheiro"),
        content: SingleChildScrollView(child: Text(dados)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Fechar"),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guardar em Ficheiro TXT'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome', border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  if (!value.contains('@')) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _mensagemController,
                decoration: InputDecoration(labelText: 'Mensagem'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma mensagem';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvarDados,
                child: Text('Salvar Dados no Ficheiro'),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _mostrarDadosLidos,
                child: Text('Ler Dados do Ficheiro'),
              ),
              SizedBox(height: 20),
              if (_feedbackMensagem.isNotEmpty)
                Text(
                  _feedbackMensagem,
                  style: TextStyle(color: _feedbackMensagem.startsWith('Erro') ? Colors.red : Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }
}