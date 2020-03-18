import 'package:doglover/api/dog_api_service.dart';
import 'package:doglover/data/source/breeds_repository.dart';
import 'package:doglover/data/source/remote/breeds_remote_data_source.dart';
import 'package:doglover/screens/breed_groups_screen.dart';
import 'package:doglover/screens/breed_screen.dart';
import 'package:doglover/screens/search_results_screen.dart';
import 'package:doglover/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<BreedsRepository>(
      create: (_) {
        return BreedsRepository(BreedsRemoteDataSource(
          DogApiService(),
        ));
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
