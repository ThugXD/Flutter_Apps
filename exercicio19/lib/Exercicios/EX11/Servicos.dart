import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LembreteModel.dart';

class ServicoLembretes {
  static const _nomeFicheiro = 'lembretes.json';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_nomeFicheiro');
  }

  Future<List<LembreteModel>> carregarLembretes() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      if (contents.isEmpty) {
        return [];
      }

      final List<dynamic> jsonData = jsonDecode(contents);
      return jsonData.map((item) => LembreteModel.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Erro ao carregar lembretes: $e");
      return [];
    }
  }

  Future<void> salvarLembretes(List<LembreteModel> lembretes) async {
    try {
      final file = await _localFile;
      final List<Map<String, dynamic>> jsonData =
      lembretes.map((lembrete) => lembrete.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonData));
    } catch (e) {
      print("Erro ao salvar lembretes: $e");
    }
  }
}

class ServicoPreferencias {
  static const _chaveUltimoTitulo = 'ultimo_titulo_editado';

  Future<void> salvarUltimoTituloEditado(String titulo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chaveUltimoTitulo, titulo);
  }

  Future<String?> lerUltimoTituloEditado() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_chaveUltimoTitulo);
  }
}