Future<void> carregarDados() async {
  print("Iniciar carregamento de Dados");

  await Future.delayed(Duration(seconds: 1));
  print("Etapa 1: Dados básicos carregados.");

  await Future.delayed(Duration(seconds: 2));
  print("Etapa 2: Configurações do utilizador carregado");

  await Future.delayed(Duration(seconds: 2));
  print("Etapa 3: Histórico de activiade.");

  print("Carregamento de dados concluido. Encerrar");
}
void main() async {
  await carregarDados();
}