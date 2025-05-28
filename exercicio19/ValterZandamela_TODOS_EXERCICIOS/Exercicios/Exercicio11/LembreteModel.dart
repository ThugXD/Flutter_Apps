class LembreteModel {
  String id;
  String titulo;
  String conteudo;
  DateTime dataCriacao;

  LembreteModel({
    required this.id,
    required this.titulo,
    required this.conteudo,
    required this.dataCriacao,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'titulo': titulo,
    'conteudo': conteudo,
    'dataCriacao': dataCriacao.toIso8601String()
  };

  factory LembreteModel.fromJson(Map<String, dynamic> json) => LembreteModel(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      conteudo: json['conteudo'] as String,
      dataCriacao: DateTime.parse(json['dataCriacao'] as String),
  );
}