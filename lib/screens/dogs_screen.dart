import 'package:doglover/models/breeds_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class DogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.brownToolbar,
        title: Center(child: Text('I Love Dogs')),
      ),
      backgroundColor: Styles.mainBackground,
      body: Container(
        child: Consumer<BreedsProvider>(builder: (context, breeds, child) {
          return Column(children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Breed breed = breeds.breedsList[index];
                  return Text(breed.name);
                },
                itemCount: breeds.breedsList.length,
              ),
            )
          ]);
        }),
      ),
    );
  }
}
