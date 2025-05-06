// main.dart
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'modelview/ImovelViewModel.dart';
import 'view/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImovelViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Imóveis',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
