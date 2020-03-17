import 'package:cached_network_image/cached_network_image.dart';
import 'package:doglover/constants.dart';
import 'package:doglover/data/breeds_provider.dart';
import 'package:doglover/models/breed.dart';
import 'package:doglover/screens/breed_screen.dart';
import 'package:doglover/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultsScreen extends StatelessWidget {
  static const String id = 'search_results_screen';

  @override
  Widget build(BuildContext context) {
    String searchQuery = ModalRoute.of(context).settings.arguments as String;
    List<Breed> filteredBreeds =
        Provider.of<BreedsProvider>(context).queryResults(searchQuery);
    return Scaffold(
      backgroundColor: Styles.mainBackground,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return DogCard(
                    breed: filteredBreeds[index],
                  );
                },
                itemCount: filteredBreeds.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DogCard extends StatefulWidget {
  const DogCard({@required this.breed});

  final Breed breed;

  @override
  _DogCardState createState() => _DogCardState();
}

class _DogCardState extends State<DogCard> {
  String _imageUrl = '';

  Future getImageUrl() async {
    if (_imageUrl.isNotEmpty) {
      return;
    }
    String url;
    try {
      url = await Provider.of<BreedsProvider>(context)
          .getBreedImageUrl(widget.breed.id.toString());
    } catch (e) {
      print(e);
      url = kError;
    } finally {
      if (this.mounted) {
        setState(() {
          _imageUrl = url;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Provider.of<BreedsProvider>(context).breedSelected(widget.breed.id);
          Navigator.pushNamed(context, BreedScreen.id);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: SizedBox(
                  child: breedImage(),
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
                            widget.breed.name,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Height',
                                style: TextStyle(color: Styles.quincy),
                              ),
                              Text(
                                '${widget.breed.height} cm',
                                style: TextStyle(color: Styles.primaryDark),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Weight',
                                style: TextStyle(color: Styles.quincy),
                              ),
                              Text(
                                '${widget.breed.weight} kg',
                                style: TextStyle(color: Styles.primaryDark),
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
  }

  Widget breedImage() {
    getImageUrl();
    if (_imageUrl.isEmpty) {
      return FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Styles.quincy),
        ),
      );
    }
    if (_imageUrl == kError) {
      return Icon(
        Icons.warning,
        color: Colors.orange,
        size: 50.0,
      );
    }
    return Image(
      image: CachedNetworkImageProvider(_imageUrl),
    );
  }
}
