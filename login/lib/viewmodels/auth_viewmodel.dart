
import 'package:flutter/cupertino.dart';
import 'package:login/services/estudante_service.dart';
import 'package:uuid/uuid.dart';
import '../models/estudante.dart';

class AuthViewModel extends ChangeNotifier {
  final EstudanteService _service = EstudanteService();
  Estudante? _estudanteActual;

  Estudante? get estudanteActual => _estudanteActual;

  bool registrar(String nome, String email, String senha) {
    final novoEstudante = Estudante(
        id: const Uuid().v4(),
        nome: nome,
        email: email,
        senha: senha,
        disciplinasIds: ['d1', 'd2']
    );

    final sucesso = _service.registrarEstudantes(novoEstudante);
    notifyListeners();
    return sucesso;
  }

  Estudante? login(String email, String senha) {
    final estudante = _service.autenticar(email, senha);
    _estudanteActual = estudante;
    notifyListeners();
    return estudante;
  }
}