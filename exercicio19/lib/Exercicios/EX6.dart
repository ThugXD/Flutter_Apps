import 'package:shared_preferences/shared_preferences.dart';

Future<String?> lerNome() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? nome = prefs.getString('nome_utilizador');
  if (nome != null) {
    print("Nome lido: $nome");
  } else {
    print("Nenhum nome encontrado.");
  }
  return nome;
}

void main() async {
  await salvarNome("Paulo Cossa");

  String? nomeLido = await lerNome();
  if (nomeLido != null) {
  }
}

Future<void> salvarNome(String nome) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('nome_utilizador', nome);
  print("Nome '$nome' salvo com sucesso!");
}