Future<String> saudar(String nome) async {
  await Future.delayed(Duration(seconds: 2));
  return "Olá, $nome";
}

void main() async {
  print("A preparar saudações...");
  String saudacao = await saudar('ThugXD');
  print(saudacao);
}