import 'package:flutter/material.dart';

showAlertDialog(
  String title,
  String content,
  Function() dismiss,
  BuildContext context,
) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: dismiss,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: TextStyle(fontSize: 24),
    ),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
