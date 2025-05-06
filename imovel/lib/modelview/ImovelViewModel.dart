import 'package:flutter/cupertino.dart';

import '../model/Imovel.dart';
import '../model/Novo.dart';
import '../model/Velho.dart';

class ImovelViewModel extends ChangeNotifier {
  final List<Imovel> _imoveis = [];
  String filtro = 'Todos';

  List<Imovel> get imoveis {
    if (filtro == 'Novo') {
      return _imoveis.where((i) => i is Novo).toList();
    } else if (filtro == 'Velho') {
      return _imoveis.where((i) => i is Velho).toList();
    }
    return _imoveis;
  }

  void adicionarImovel(Imovel imovel) {
    _imoveis.add(imovel);
    notifyListeners();
  }

  void removerImovel(int index) {
    _imoveis.removeAt(index);
    notifyListeners();
  }

  void atualizarImovel(int index, Imovel novoImovel) {
    _imoveis[index] = novoImovel;
    notifyListeners();
  }

  void setFiltro(String tipo) {
    filtro = tipo;
    notifyListeners();
  }
}
