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
            buildImage(breeds),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      breed.name,
                      style: TextStyle(
                          color: Styles.primaryDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
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
              ]),
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
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Styles.primaryDark),
      ),
    );
  }
}
