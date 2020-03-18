import 'package:cached_network_image/cached_network_image.dart';
import 'package:doglover/constants.dart';
import 'package:doglover/models/breed.dart';
import 'package:doglover/screens/breed_screen.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/viewmodel/breed_card_view_model.dart';
import 'package:doglover/viewmodel/search_results_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatelessWidget {
  static const String id = 'search_results_screen';

  @override
  Widget build(BuildContext context) {
    String searchQuery = ModalRoute.of(context).settings.arguments as String;
    return ViewModelProvider<SearchViewModel>(
        model: SearchViewModel(context: context),
        builder: (SearchViewModel model) {
          model.queryResults(searchQuery);
          List<Breed> filteredBreeds = model.filteredBreedsList;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Styles.mainBackground,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return DogCard(
                          breed: filteredBreeds[index],
                        );
                      },
                      itemCount: model.filteredBreedsList.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class DogCard extends StatelessWidget {
  const DogCard({@required this.breed});

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BreedCardViewModel>(
        model: BreedCardViewModel(breed, context: context),
        builder: (BreedCardViewModel model) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, BreedScreen.id,
                    arguments: model.breed.id);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: SizedBox(
                        child: breedImage(model.breedImageUrl),
                        width: 160,
                        height: 124,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 0, 0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  model.breed.name,
                                  style: kSmallLabelStyle,
                                ),
                              ),
                              Icon(Icons.favorite)
                            ],
                          ),
                          SizedBox(
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Height',
                                      style: TextStyle(color: Styles.quincy),
                                    ),
                                    Text(
                                      '${model.breed.height} cm',
                                      style:
                                          TextStyle(color: Styles.primaryDark),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Weight',
                                      style: TextStyle(color: Styles.quincy),
                                    ),
                                    Text(
                                      '${model.breed.weight} kg',
                                      style:
                                          TextStyle(color: Styles.primaryDark),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget breedImage(String imageUrl) {
    if (imageUrl.isEmpty) {
      return FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Styles.quincy),
        ),
      );
    }
    if (imageUrl == kError) {
      return Icon(
        Icons.warning,
        color: Colors.orange,
        size: 50.0,
      );
    }
    return Image(
      image: CachedNetworkImageProvider(imageUrl),
    );
  }
}
