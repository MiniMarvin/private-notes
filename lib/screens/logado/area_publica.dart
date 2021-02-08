import 'package:flutter/material.dart';
import 'package:private_notes/components/note_grid.dart';

class AreaPublica extends StatefulWidget {
  @override
  _AreaPublicaState createState() => _AreaPublicaState();
}

class _AreaPublicaState extends State<AreaPublica> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: NoteGrid(),
    );
  }
}
