import '../models/estudante.dart';
class EstudanteService {
  final List<Estudante> _estudantes = [];

  bool registrarEstudantes(Estudante estudante) {
    final existe =_estudantes.any((est) => est.email == estudante.email);
    if (existe) return false; //Prk já existe

    _estudantes.add(estudante);
    return true;
  }

  Estudante? autenticar(String email, String senha) {
    return _estudantes.firstWhere(
        (est) => est.email == email && est.senha == senha,
        orElse: () => null,
    );
  }

  Estudante? buscarPorId(String id) {
    return _estudantes.firstWhere(
        (est) => est.id == id,
        orElse: () => null,
    );
  }
}