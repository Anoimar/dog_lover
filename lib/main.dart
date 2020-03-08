import 'package:doglover/screens/breed_groups_screen.dart';
import 'package:doglover/screens/breed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/breeds_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BreedsProvider>(
      create: (context) {
        return BreedsProvider();
      },
      child: MaterialApp(
          title: 'I Love Dogs',
          initialRoute: BreedGroupsScreen.id,
          routes: {
            BreedGroupsScreen.id: (context) => BreedGroupsScreen(),
            BreedScreen.id: (context) => BreedScreen()
          }),
    );
  }
}
