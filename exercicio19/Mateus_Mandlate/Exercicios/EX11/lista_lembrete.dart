import 'package:flutter/material.dart';
import 'LembreteModel.dart';
import 'servicos.dart';
import 'editar_lembretes.dart';

class TelaListaLembretes extends StatefulWidget {
  @override
  _TelaListaLembretesState createState() => _TelaListaLembretesState();
}

class _TelaListaLembretesState extends State<TelaListaLembretes> {
  List<LembreteModel> _listaDeLembretes = [];
  bool _isLoading = true;
  final ServicoLembretes _servicoLembretes = ServicoLembretes();

  @override
  void initState() {
    super.initState();
    _carregarLembretesDaPersistencia();
  }

  Future<void> _carregarLembretesDaPersistencia() async {
    setState(() {
      _isLoading = true;
    });
    final lembretesCarregados = await _servicoLembretes.carregarLembretes();
    // Ordena por data de criação, os mais recentes primeiro
    lembretesCarregados.sort((a, b) => b.dataCriacao.compareTo(a.dataCriacao));
    if (mounted) {
      setState(() {
        _listaDeLembretes = lembretesCarregados;
        _isLoading = false;
      });
    }
  }

  void _navegarParaEditarLembrete([LembreteModel? lembrete]) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaEditarLembrete(lembrete: lembrete),
      ),
    );

    // Se a tela de edição retornou 'true' (indicando que algo foi salvo), recarrega a lista
    if (resultado == true && mounted) {
      _carregarLembretesDaPersistencia();
    }
  }

  Future<void> _removerLembrete(String id) async {
    // Confirmação antes de apagar
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar'),
          content: Text('Tem certeza que deseja apagar este lembrete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Apagar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      List<LembreteModel> lembretesAtuais = await _servicoLembretes.carregarLembretes();
      lembretesAtuais.removeWhere((l) => l.id == id);
      await _servicoLembretes.salvarLembretes(lembretesAtuais);
      _carregarLembretesDaPersistencia(); // Recarrega a lista para refletir a remoção
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lembretes'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _listaDeLembretes.isEmpty
          ? Center(
        child: Text(
          'Nenhum lembrete ainda.\nToque em "+" para adicionar um novo.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: _listaDeLembretes.length,
        itemBuilder: (context, index) {
          final lembrete = _listaDeLembretes[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              title: Text(lembrete.titulo, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                lembrete.conteudo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () => _removerLembrete(lembrete.id),
              ),
              onTap: () => _navegarParaEditarLembrete(lembrete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navegarParaEditarLembrete(),
        child: Icon(Icons.add),
        tooltip: 'Novo Lembrete',
      ),
    );
  }
}