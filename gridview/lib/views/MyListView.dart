
import 'package:flutter/material.dart';
import 'package:gridview/models/ListDataItems.dart';

class MyLisView extends StatelessWidget {
  MyLisView({ super.key });

  final ListDataItems items = ListDataItems();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      //Indicar a direcção do scrool e o numero max do items
      scrollDirection: Axis.horizontal,
      itemCount: items.meses.length,
      itemBuilder: (context, index){
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              //criar uma ListTile, que ao ser criado mosra uma mensagem de 2 seg
              child: ListTile(
                title: Text(items.meses[index]),
                onTap: (){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2,milliseconds: 5),
                      content: Text('Selecionado ${items.meses[index]}',
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                    ),
                    ),
                  );
                },
              ),
            ),
              const SizedBox(width: 10.0)
          ],
        );
      },
    );
  }
}