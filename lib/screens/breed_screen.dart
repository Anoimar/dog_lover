import 'package:doglover/models/breed.dart';
import 'package:doglover/models/breeds_provider.dart';
import 'package:doglover/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BreedScreen extends StatelessWidget {
  static const String id = 'breed_screen';

  @override
  Widget build(BuildContext context) {
    String selectedBreedId =
        ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Styles.mainBackground,
      extendBodyBehindAppBar: true,
      body: Container(
        child: Consumer<BreedsProvider>(builder: (context, breeds, child) {
          Breed breed = breeds.selectedBreed;
          return Column(children: [
            Flexible(
              child: buildImage(breeds),
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
                      firstTraitValue: breed.bredFor,
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
                      secondTraitValue:
                          breed.origin != null ? breed.origin : '?',
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: DogTraitColumn(
                            traitName: 'Temperament',
                            value: breed.temperament,
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }

  Widget buildImage(BreedsProvider breeds) {
    String imageUrl = breeds.imageUrl;
    if (imageUrl.isNotEmpty) {
      return Image.network(imageUrl);
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
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: kEunryTextStyle,
        )
      ],
    );
  }
}
