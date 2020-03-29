import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final bool isVisible;

  const LoadingView(this.isVisible);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(150, 211, 211, 211),
        height: !isVisible ? 0 : null);
  }
}
