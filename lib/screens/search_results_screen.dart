import 'package:doglover/models/breed.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/viewmodel/search_results_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/dog_card.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class SearchResultsScreen extends StatelessWidget {
  static const String id = 'search_results_screen';

  @override
  Widget build(BuildContext context) {
    String searchQuery = ModalRoute.of(context).settings.arguments as String;
    return ViewModelProvider<SearchViewModel>(
        model: SearchViewModel(context: context),
        builder: (SearchViewModel model) {
          model.queryResults(searchQuery);
          List<Tuple2<bool, Breed>> filteredBreeds = model.filteredBreedsList;
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Styles.mainBackground,
            body: Column(
              children: <Widget>[
                model.filteredBreedsList.length > 0
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              var breedFav = filteredBreeds[index];
                              return DogCard(
                                isFav: breedFav.item1,
                                breed: breedFav.item2,
                              );
                            },
                            itemCount: model.filteredBreedsList.length,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 0.0, 32.0),
                              child: Image.asset('assets/no_results.jpeg',
                                  height: 350.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('No results to show',
                                    style: kEmptyStatePrimaryTextStyle),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Maybe wrong spelling?',
                                  style: kEmptyStateSecondaryTextStyle,
                                ),
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                        ),
                      ),
              ],
            ),
          );
        });
  }
}
