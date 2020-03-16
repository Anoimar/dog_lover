import 'package:doglover/models/breeds_provider.dart';
import 'package:doglover/screens/search_results_screen.dart';
import 'package:doglover/widgets/group_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class BreedGroupsScreen extends StatelessWidget {
  static const String id = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.mainBackground,
      body: SafeArea(
        child: Container(
          child: Consumer<BreedsProvider>(builder: (context, breeds, child) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchCard(),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GroupTitle(
                      entry: breeds.breedListViewEntries[index],
                    );
                  },
                  itemCount: breeds.breedListViewEntries.length,
                ),
              )
            ]);
          }),
        ),
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.search),
            ),
            Expanded(
              child: TextField(
                onSubmitted: (text) {
                  if (text.isNotEmpty) {
                    Navigator.pushNamed(context, SearchResultsScreen.id,
                        arguments: text);
                  }
                },
                autofocus: false,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Styles.eunry),
                  hintText: 'Search here',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
