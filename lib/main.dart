import 'package:doglover/screens/breed_groups_screen.dart';
import 'package:doglover/screens/breed_screen.dart';
import 'package:doglover/screens/search_results_screen.dart';
import 'package:doglover/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/breeds_provider.dart';

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
          theme: ThemeData(accentColor: Styles.primaryDark),
          initialRoute: BreedGroupsScreen.id,
          routes: {
            BreedGroupsScreen.id: (context) => BreedGroupsScreen(),
            BreedScreen.id: (context) => BreedScreen(),
            SearchResultsScreen.id: (context) => SearchResultsScreen()
          }),
    );
  }
}
