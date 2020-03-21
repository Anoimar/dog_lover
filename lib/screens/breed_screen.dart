import 'package:cached_network_image/cached_network_image.dart';
import 'package:doglover/constants.dart';
import 'package:doglover/models/breed.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/viewmodel/breed_details_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:flutter/material.dart';

class BreedScreen extends StatelessWidget {
  static const String id = 'breed_screen';

  @override
  Widget build(BuildContext context) {
    int selectedId = ModalRoute.of(context).settings.arguments as int;
    return ViewModelProvider<BreedDetailsViewModel>(
        model: BreedDetailsViewModel(context: context),
        builder: (BreedDetailsViewModel model) {
          model.breedSelected(selectedId);
          return Scaffold(
              appBar: AppBarBuilder.createTransparentAppBar(),
              backgroundColor: Styles.mainBackground,
              extendBodyBehindAppBar: true,
              body: Container(
                  child: model.selectedBreed != null
                      ? BreedDetails(model)
                      : Container()));
        });
  }
}

class BreedDetails extends StatelessWidget {
  const BreedDetails(this.model);
  final BreedDetailsViewModel model;

  @override
  Widget build(BuildContext context) {
    Breed breed = model.selectedBreed;
    return Column(children: [
      Flexible(
        child: buildImage(model),
        flex: 1,
      ),
      Flexible(
        flex: 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50.0,
                  ),
                  Text(
                    breed.name,
                    style: kMediumLabelStyle,
                  ),
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: FloatingActionButton(
                      backgroundColor: Styles.primaryDark,
                      child: Icon(
                        Icons.favorite,
                      ),
                    ),
                  )
                ],
              ),
              DogTraitRow(
                firstTrait: 'Bred for:',
                firstTraitValue: breed.bredFor != null ? breed.bredFor : '',
                secondTrait: 'Breed group:',
                secondTraitValue: breed.group,
              ),
              DogTraitRow(
                firstTrait: "Weight:",
                firstTraitValue: '${breed.weight} kg',
                secondTrait: "Height:",
                secondTraitValue: '${breed.height} cm',
              ),
              DogTraitRow(
                firstTrait: 'Life expectancy:',
                firstTraitValue: breed.lifeExpectancy,
                secondTrait: 'Origin:',
                secondTraitValue: breed.origin != null ? breed.origin : '?',
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: DogTraitColumn(
                        traitName: 'Temperament',
                        value: breed.temperament,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    ]);
  }

  Widget buildImage(BreedDetailsViewModel viewModel) {
    String imageUrl = viewModel.selectedBreedImageUrl;
    if (imageUrl == kError) {
      return SafeArea(
        child: Icon(
          Icons.warning,
          color: Colors.orange,
          size: 80.0,
        ),
      );
    }
    if (imageUrl.isNotEmpty) {
      return Image(
        image: CachedNetworkImageProvider(imageUrl),
      );
    }
    return SafeArea(
      child: FractionallySizedBox(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Styles.primaryDark),
        ),
      ),
    );
  }
}

class DogTraitRow extends StatelessWidget {
  const DogTraitRow(
      {this.firstTrait,
      this.secondTrait,
      this.firstTraitValue,
      this.secondTraitValue});

  final String firstTrait;
  final String secondTrait;
  final String firstTraitValue;
  final String secondTraitValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          flex: 1,
          child: DogTraitColumn(
            traitName: firstTrait,
            value: firstTraitValue,
          ),
        ),
        Expanded(
          flex: 1,
          child: DogTraitColumn(
            traitName: secondTrait,
            value: secondTraitValue,
          ),
        )
      ]),
    );
  }
}

class DogTraitColumn extends StatelessWidget {
  const DogTraitColumn({this.traitName, this.value});

  final String traitName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          traitName,
          style: kSmallLabelStyle,
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: kEunryTextStyle,
        )
      ],
    );
  }
}
