import 'package:doglover/styles.dart';
import 'package:flutter/material.dart';

class FormInputCard extends StatelessWidget {
  final IconData icon;
  final String hintText;

  FormInputCard(this.icon, this.hintText);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Styles.primaryDark,
            ),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
