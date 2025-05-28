
import 'package:flutter/material.dart';
import 'LembreteModel.dart';
import 'servicos.dart';

class TelaEditarLembrete extends StatefulWidget {
  final LembreteModel? lembrete;

  TelaEditarLembrete({Key? key, this.lembrete}) : super(key: key);

  @override
  _TelaEditarLembreteState createState() => _TelaEditarLembreteState();
}

class _TelaEditarLembreteState extends State<TelaEditarLembrete> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _conteudoController;

  final ServicoLembretes _servicoLembretes = ServicoLembretes();
  final ServicoPreferencias _servicoPreferencias = ServicoPreferencias();

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.lembrete?.titulo ?? '');
    _conteudoController = TextEditingController(text: widget.lembrete?.conteudo ?? '');

    // Se for um novo lembrete e o título estiver vazio, tenta carregar o último título editado
    if (widget.lembrete == null && _tituloController.text.isEmpty) {
      _carregarUltimoTituloPreferido();
    }
  }

  Future<void> _carregarUltimoTituloPreferido() async {
    String? ultimoTitulo = await _servicoPreferencias.lerUltimoTituloEditado();
    if (ultimoTitulo != null && mounted) { // Verifica se o widget ainda está montado
      setState(() {
        _tituloController.text = ultimoTitulo;
      });
    }
  }

  Future<void> _salvarLembrete() async {
    if (_formKey.currentState!.validate()) {
      final titulo = _tituloController.text;
      final conteudo = _conteudoController.text;

      List<LembreteModel> todosLembretes = await _servicoLembretes.carregarLembretes();

      if (widget.lembrete != null) {
        int index = todosLembretes.indexWhere((l) => l.id == widget.lembrete!.id);
        if (index != -1) {
          todosLembretes[index].titulo = titulo;
          todosLembretes[index].conteudo = conteudo;
        }
      } else {
        // Criar novo lembrete
        final novoLembrete = LembreteModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(), // ID único simples
          titulo: titulo,
          conteudo: conteudo,
          dataCriacao: DateTime.now(),
        );
        todosLembretes.add(novoLembrete);
      }

      await _servicoLembretes.salvarLembretes(todosLembretes);
      await _servicoPreferencias.salvarUltimoTituloEditado(titulo);

      if (mounted) {
        Navigator.pop(context, true); // Retorna true para indicar que algo foi salvo
      }
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _conteudoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lembrete == null ? 'Novo Lembrete' : 'Editar Lembrete'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _salvarLembrete,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _conteudoController,
                decoration: InputDecoration(
                  labelText: 'Conteúdo',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o conteúdo';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}