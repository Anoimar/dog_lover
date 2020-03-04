import 'package:doglover/screens/dogs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/breeds_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I Love Dogs',
      home: ChangeNotifierProvider<BreedsProvider>(
          create: (context) {
            return BreedsProvider();
          },
          child: DogsScreen()),
    );
  }
}
