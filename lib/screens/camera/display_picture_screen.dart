// A widget that displays the picture taken by the user.
import 'dart:io';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  DisplayPictureScreen({this.imagePath});

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  _confirmar() {
    Navigator.pop(context, this.widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('confirmar foto')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: <Widget>[
          Image.file(File(this.widget.imagePath)),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: _confirmar,
              child: Text('confirmar'),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
        ],
      ),
    );
  }
}
