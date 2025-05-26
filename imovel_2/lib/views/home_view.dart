import 'package:flutter/material.dart';

import 'Adicionar.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: false,
        backgroundColor: Colors.indigo,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _styleButton(
              context,
              label: 'Adicionar Imóvel',
              onPressed: () {},
              // onPressed: () => Navigator.push(
              //   context,
              //   //MaterialPageRoute(builder: (_) => AdicionarImovelPage()),
              // ),
              textColor: Colors.white,
            ),
            SizedBox(height: 20),
            _styleButton(
              context,
              label: 'Adicionar Imóvel',
              onPressed: () => Navigator.push(
                 context,
                 MaterialPageRoute(builder: (_) => AdicionarImovelPage()),
              ),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  //EStilar o botão
  Widget _styleButton(BuildContext context, {
    required String label,
    required VoidCallback onPressed,
    Color textColor = Colors.white
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 18),
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            elevation: 6,
          ),
        child: Text(
          label,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
      ),
    );
  }
}