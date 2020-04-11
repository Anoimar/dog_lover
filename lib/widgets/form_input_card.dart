import 'package:doglover/styles.dart';
import 'package:flutter/material.dart';

class FormInputCard extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool isObscured;
  final Function getText;
  final String Function(String) validation;
  final fieldKey;

  FormInputCard(this.icon, this.hintText,
      {this.isObscured = false, getText, this.validation, this.fieldKey})
      : getText = getText ??
            ((String text) {
              print(text);
            });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          key: fieldKey,
          onSaved: (String value) {
            getText(value);
          },
          validator: (String input) {
            if (input.isEmpty) {
              return "Field can't be empty";
            }
            if (validation == null) {
              return null;
            }
            String error = validation(input);
            return error;
          },
          obscureText: isObscured,
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
