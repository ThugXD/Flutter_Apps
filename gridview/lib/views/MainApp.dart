import 'package:flutter/material.dart';
import 'package:gridview/views/MyGridView.dart';
import 'package:gridview/views/MyListView.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,

      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu),),
          title: Text('Principal'),
          actions: [IconButton(onPressed: () {} , icon: Icon(Icons.settings))],
          backgroundColor: Colors.white54,
        ),

        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: MyLisView(),
            ),
          ],
        ),
        backgroundColor: Colors.amberAccent[180],
      ),
    );
  }
}
