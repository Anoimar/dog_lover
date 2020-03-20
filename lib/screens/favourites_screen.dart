import 'package:doglover/viewmodel/favourite_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  static const String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FavouriteViewModel>(
      model: FavouriteViewModel(context),
      builder: (FavouriteViewModel model) {
        return Scaffold(
          body: Container(
            child: Center(
              child: Text('Favourite'),
            ),
          ),
        );
      },
    );
  }
}
