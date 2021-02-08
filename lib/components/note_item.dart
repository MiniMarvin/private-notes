import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  final int times;

  NoteItem({@required this.times});

  @override
  Widget build(BuildContext context) {
    String content = 'fazendo um teste de como eu posso escrever as coisas tentando fazer com que as coisas façam algum sentido na verdade. ';
    for (int i = 0; i < times; i++) {
      content += content;
    }

    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              'titulo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(height: 10),
            Text(
              content,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(0xff, 0xd9, 0xeb, 1),
      ),
    );
  }
}
