
import 'dart:io';

void main() {
    print('Insira o primeiro Valor: ');
    String? ler1 = stdin.readLineSync();

    print('Insira o segundo Valor: ');
    String? ler2 = stdin.readLineSync();

    if(ler1 != null && ler2 != null) {
      double? valor1 = double.tryParse(ler1);
      double? valor2 = double.tryParse(ler2);

      if (valor1 == null || valor2 == null) {
        print('Valores inválidos!');
        return;
      }

      distinguirValores(valor1, valor2);
    }
}

void distinguirValores(double valor1, double valor2) {
  if(valor1 == -valor2) {
    print('São valor opostos');
  } else if( valor1 != 0 && valor2 != 0 && (1/valor1 == valor2 || 1/valor2 == valor1)) {
    print('Valores são inversos');
  } else {
    print('Os valores não são opostos nem inversos');
  }
}