import 'package:doglover/screens/search_results_screen.dart';
import 'package:doglover/viewmodel/breeds_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/group_title.dart';
import 'package:doglover/widgets/search_card.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class BreedGroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BreedsViewModel>(
        model: BreedsViewModel(context: context),
        builder: (BreedsViewModel model) {
          return Scaffold(
            backgroundColor: Styles.mainBackground,
            body: SafeArea(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchCard(
                    onSubmitted: (text) => Navigator.pushNamed(
                        context, SearchResultsScreen.id,
                        arguments: text)),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GroupTitle(
                      entry: model.breedListViewEntries[index],
                    );
                  },
                  itemCount: model.breedListViewEntries.length,
                ),
              ),
            ])),
          );
        });
  }
}
