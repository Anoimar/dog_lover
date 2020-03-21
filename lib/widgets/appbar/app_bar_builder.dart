import 'package:flutter/material.dart';

class AppBarBuilder {
  static createTransparentAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
