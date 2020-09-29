import 'package:doglover/styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {this.onPressed,
      this.buttonColor,
      this.buttonText,
      this.isActive = true});

  final Function onPressed;
  final Color buttonColor;
  final String buttonText;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: buttonColor,
      onPressed: isActive ? onPressed : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          buttonText,
          style: TextStyle(
              color: isActive ? Colors.white : Styles.almostWhite,
              fontSize: 18.0),
        ),
      ),
    );
  }
}
