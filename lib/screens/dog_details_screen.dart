import 'package:cached_network_image/cached_network_image.dart';
import 'package:doglover/constants.dart';
import 'package:doglover/models/dog.dart';
import 'package:doglover/screens/arguments/dog_details_args.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/viewmodel/dog_details_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:flutter/material.dart';

class DogDetailsScreen extends StatelessWidget {
  static const String id = 'dog_details_screen';

  @override
  Widget build(BuildContext context) {
    DogDetailsArgs args =
        ModalRoute.of(context).settings.arguments as DogDetailsArgs;
    int selectedId = args.id;
    Function onEdited = args.onEdited;
    bool isMyDog = args.isMyDog;
    return ViewModelProvider<DogDetailsViewModel>(
        model: DogDetailsViewModel(context: context),
        builder: (DogDetailsViewModel model) {
          model.dogSelected(selectedId);
          return Scaffold(
              appBar: AppBarBuilder.createTransparentAppBar(),
              backgroundColor: Styles.mainBackground,
              extendBodyBehindAppBar: true,
              body: Container(
                  child: model.dog != null
                      ? DogDetails(
                          model,
                          isMyDog,
                          onEdited: onEdited,
                        )
                      : Container()));
        });
  }
}

class DogDetails extends StatelessWidget {
  const DogDetails(this.model, this.isMyDog, {this.onEdited});
  final DogDetailsViewModel model;
  final bool isMyDog;
  final Function onEdited;

  @override
  Widget build(BuildContext context) {
    Dog dog = model.dog;
    return Column(children: [
      Flexible(
        child: buildImage(model),
        flex: 1,
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50.0,
                  ),
                  Text(
                    dog.name,
                    style: kMediumLabelStyle,
                  ),
                  isMyDog
                      ? SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: Styles.buttonColor,
                            child: Icon(
                              Icons.delete,
                            ),
                          ),
                        )
                      : Container(
                          width: 50.0,
                        ),
                ],
              ),
            ]),
          ),
        ),
        flex: 1,
      ),
    ]);
  }

  Widget buildImage(DogDetailsViewModel viewModel) {
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
