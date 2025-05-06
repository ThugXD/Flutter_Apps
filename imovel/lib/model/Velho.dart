import 'Imovel.dart';

class Velho extends Imovel {
  double desconto;

  Velho({required super.endereco, required super.preco, required this.desconto});

  double getPrecoFinal() => preco - desconto;
  String getInfoDesconto() => 'Desconto: \$${desconto.toStringAsFixed(2)}';
}
