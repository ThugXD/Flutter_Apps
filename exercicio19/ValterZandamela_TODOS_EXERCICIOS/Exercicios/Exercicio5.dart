import 'package:shared_preferences/shared_preferences.dart';

Future<void> salvarNome(String nome) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  await preferences.setString('nome_utilizador', nome);
  print("Nome, '$nome' salvo com sucesso");
}

void main() async {
  await salvarNome("Paulo Cossa");
}