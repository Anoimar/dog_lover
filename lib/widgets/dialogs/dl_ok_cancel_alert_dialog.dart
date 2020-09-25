import 'package:flutter/material.dart';

class DLOkCancelDialog extends StatelessWidget {
  final String title;
  final String text;
  final Function onConfirmed;

  const DLOkCancelDialog({this.title, this.text, this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              onConfirmed();
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL'),
          )
        ]);
  }
}
