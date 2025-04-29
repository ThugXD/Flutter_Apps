import 'package:flutter/material.dart';
import 'home_page.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        home: HomePage(),
    );
  }
}