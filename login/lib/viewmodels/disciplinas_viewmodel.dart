
import 'package:login/models/disciplinas.dart';
import '../models/estudante.dart';

class DisciplinasVieModel {
  final List<Disciplinas> _todasDisciplinas = [
    Disciplinas(id: 'd1', nome: 'Matemática'),
    Disciplinas(id: 'd2', nome: 'Português'),
    Disciplinas(id: 'd2', nome: 'Fisica'),
  ];
  List<Disciplinas> getDisciplinasDoEstudante(Estudante estudante) {
    return _todasDisciplinas
        .where((disciplina) => estudante.disciplinasIds.contains(disciplina.id))
        .toList();
  }

}