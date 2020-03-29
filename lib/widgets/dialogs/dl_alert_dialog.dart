import 'package:flutter/material.dart';

class DLAlertDialog extends StatelessWidget {
  final String title;
  final String text;
  final Function onConfirmed;

  const DLAlertDialog({this.title, this.text, this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: <Widget>[
        FlatButton(
          onPressed: onConfirmed,
          child: Text('OK'),
        )
      ],
    );
  }
}
