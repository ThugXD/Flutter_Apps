
import 'package:flutter/material.dart';
import 'lista_lembrete.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lembretes',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Escolhe uma cor primária
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      home: TelaListaLembretes(), // Define a tela inicial
    );
  }
}