Future<String> obterNome() async {
  await Future.delayed(Duration(seconds: 2));
  return "Paulo Cossa";
}

void main() async {
  print("A obter nome do User");
  String nome = await obterNome();
  print ("Nome do user:  $nome");
}