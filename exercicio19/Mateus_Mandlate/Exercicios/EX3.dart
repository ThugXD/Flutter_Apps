

Future<String> pesquisarProduto(String nomeProduto) async {
  print("A pesquisar por: $nomeProduto ...");
  await Future.delayed(Duration(seconds: 1));

  if(nomeProduto.toLowerCase() == "Produto Inexistente") {
    throw Exception("Erro: Produto '$nomeProduto' não encontrado!");
  } else {
    return "Profuto '$nomeProduto' encontrado. Preço 120mts";
  }
}

void main() async {
  try {
    String resultado = await pesquisarProduto("Produto existente");
    print(resultado);

    String resultadoErro = await pesquisarProduto("Produnto não existe");
    print(resultadoErro);
  } catch (e) {
    print(e.toString());
  }
}