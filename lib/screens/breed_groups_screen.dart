import 'package:doglover/models/breeds_provider.dart';
import 'package:doglover/widgets/group_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class BreedGroupsScreen extends StatelessWidget {
  static const String id = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.primaryDark,
        title: Center(child: Text('I Love Dogs')),
      ),
      backgroundColor: Styles.mainBackground,
      body: Container(
        child: Consumer<BreedsProvider>(builder: (context, breeds, child) {
          return Column(children: [
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
    );
  }
}
