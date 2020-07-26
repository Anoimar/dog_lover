import 'package:doglover/models/breed.dart';
import 'package:doglover/viewmodel/favourite_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/dog_card.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class FavouriteScreen extends StatelessWidget {
  static const String id = 'favourite_screen';

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FavouriteViewModel>(
      model: FavouriteViewModel(context),
      builder: (FavouriteViewModel model) {
        return Scaffold(
            backgroundColor: Styles.mainBackground,
            body: SafeArea(
              child: Column(children: [
                model.favouriteBreedsList.toList().length > 0
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final Breed favBreed =
                                  model.favouriteBreedsList[index];
                              return Dismissible(
                                key: Key(favBreed.name),
                                onDismissed: (direction) {
                                  model.removeFromFavourite(favBreed);
                                },
                                child: DogCard(
                                  isFav: true,
                                  breed: favBreed,
                                ),
                              );
                            },
                            itemCount: model.favouriteBreedsList.length,
                          ),
                        ),
                      )
                    : Text('NO'),
              ]),
            ));
      },
    );
  }
}
