import 'package:cached_network_image/cached_network_image.dart';
import 'package:doglover/constants.dart';
import 'package:doglover/models/dog.dart';
import 'package:doglover/screens/arguments/dog_details_args.dart';
import 'package:doglover/screens/arguments/edit_dog_args.dart';
import 'package:doglover/screens/breed_screen.dart';
import 'package:doglover/screens/edit_dog_pic_screen.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/viewmodel/dog_details_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:doglover/widgets/loading_view.dart';
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
              body: Stack(
                children: [
                  Container(
                      child: model.dog != null
                          ? DogDetails(
                              model,
                              isMyDog,
                              onEdited: onEdited,
                            )
                          : Container()),
                  LoadingView(model.viewState == ViewState.loading)
                ],
              ));
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
        flex: 3,
      ),
      Flexible(
        flex: 4,
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
                  dog.name,
                  style: kMediumLabelStyle,
                ),
                isMyDog
                    ? SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: FloatingActionButton(
                          onPressed: () async {
                            if (await model.deleteDogPic()) {
                              onEdited();
                              Navigator.pop(context);
                            }
                          },
                          backgroundColor: Styles.buttonColor,
                          child: Icon(
                            Icons.delete_forever,
                          ),
                        ),
                      )
                    : Container(
                        width: 50.0,
                      ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DogTraitColumn(
                  traitName: "Breed",
                  value: model.dog.breed ?? " ???",
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Description",
                            style: kSmallLabelStyle,
                          ),
                        ),
                        Container(
                          height: 180.0,
                          child: SingleChildScrollView(
                            child: Text(
                              model.dog.description ?? "",
                              style: kEunryTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              color: Styles.eunry,
                              textColor: Styles.almostWhite,
                              child: Text(
                                'Edit details',
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, EditDogPicScreen.id,
                                    arguments:
                                        EditDogArgs.create(onEdited, dog));
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
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
      return Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Container(
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(imageUrl),
                fit: BoxFit.scaleDown),
          ),
        ),
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
