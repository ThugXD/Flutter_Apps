import 'Imovel.dart';

class Novo extends Imovel {
  double adicional;

  Novo({required super.endereco, required super.preco, required this.adicional});

  double getPrecoFinal() => preco + adicional;
  String getInfoAdicional() => 'Adicional: \$${adicional.toStringAsFixed(2)}';
}
