import 'dart:ui';

import 'package:flutter/material.dart';

abstract class Styles {
  static const Color primaryDark = Color.fromARGB(255, 91, 58, 39);
  static const Color buttonColor = Color.fromARGB(255, 91, 58, 39);
  static const Color mainBackground = Color.fromARGB(255, 245, 234, 215);
  static const Color quincy = Color.fromARGB(255, 93, 60, 44);
  static const Color eunry = Color.fromARGB(255, 205, 167, 161);
  static const Color almostWhite = Color.fromARGB(255, 234, 234, 232);
  static const Color inactiveGray = Color.fromARGB(255, 146, 146, 146);
  static const Color textGray = Color.fromARGB(255, 100, 100, 100);
}

const kMediumLabelStyle = TextStyle(
    color: Styles.primaryDark, fontWeight: FontWeight.bold, fontSize: 18.0);

const kSmallLabelStyle = TextStyle(
    color: Styles.primaryDark, fontWeight: FontWeight.bold, fontSize: 16.0);

const kEunryTextStyle = TextStyle(color: Styles.quincy, fontSize: 16.0);

const kEmptyStatePrimaryTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
const kEmptyStateSecondaryTextStyle =
    TextStyle(color: Styles.textGray, fontSize: 16.0);
