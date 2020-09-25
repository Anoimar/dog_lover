import 'package:cached_network_image/cached_network_image.dart';
import 'package:doglover/models/dog.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/viewmodel/account_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/dialogs/dl_ok_cancel_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountScreen extends StatelessWidget {
  final Function onLogOff;

  const AccountScreen({this.onLogOff});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AccountViewModel>(
      model: AccountViewModel(context),
      builder: (AccountViewModel model) {
        const avatarRadius = 64.0;
        const topMargin = 184.0;

        return Scaffold(
          backgroundColor: Styles.mainBackground,
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: topMargin),
                child: Container(
                  alignment: AlignmentDirectional.topEnd,
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 32, 0),
                    child: PopupMenuButton(
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          child: Text('Log off'),
                          value: 'Log off',
                        )
                      ],
                      onSelected: (_) {
                        model.logOff();
                        onLogOff();
                      },
                      child: Icon(
                        Icons.more_horiz,
                        size: 48.0,
                        color: Styles.buttonColor,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: topMargin - avatarRadius),
                child: Container(
                  alignment: AlignmentDirectional.topCenter,
                  child: Column(
                    children: <Widget>[
                      Stack(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: avatarRadius,
                            backgroundImage: model.userImageUrl != ''
                                ? CachedNetworkImageProvider(model.userImageUrl)
                                : AssetImage('assets/login_background.jpeg'),
                          ),
                        ),
                        Positioned(
                          bottom: 4.0,
                          right: 4.0,
                          child: SizedBox(
                            width: 48.0,
                            height: 48.0,
                            child: FloatingActionButton(
                              onPressed: () async {
                                var image = await ImagePicker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 10);
                                model.imagePicked(image);
                              },
                              backgroundColor: Styles.primaryDark,
                              child: Icon(
                                Icons.photo_camera,
                              ),
                            ),
                          ),
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          model.name,
                          style: kMediumLabelStyle.copyWith(
                              color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Text(model.email),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: SizedBox(
                                height: 2.0,
                                width: double.infinity,
                              ),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    Colors.black,
                                    Styles.almostWhite,
                                    Colors.white,
                                    Styles.almostWhite,
                                    Colors.black
                                  ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'My dogs',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () async {
                                      var image = await ImagePicker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 10);
                                      model.addNewPic(image, "Krypto", "mixed",
                                          "Superman's Dog");
                                    },
                                    icon: Text('Add a dog pic'),
                                    label: Icon(Icons.add),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 200.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var dogModel = model.dogs[index];
                                  return InkWell(
                                    onTap: () {
                                      print("card pressed");
                                    },
                                    child: Stack(children: [
                                      DogSmallCard(dogModel: dogModel),
                                      Positioned(
                                        top: 8.0,
                                        right: 16.0,
                                        child: Container(
                                          height: 32.0,
                                          width: 32.0,
                                          child: FittedBox(
                                            child: FloatingActionButton(
                                              child: Icon(Icons.close),
                                              onPressed: () {
                                                showDeletePicDialog(
                                                  context,
                                                  () {
                                                    model.deleteDogPic(
                                                        dogModel.id);
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                  );
                                },
                                itemCount: model.dogs.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

void showDeletePicDialog(BuildContext context, Function onConfirmDelete) {
  showDialog(
      context: context,
      builder: (context) {
        return DLOkCancelDialog(
          title: 'Remove pic',
          text: 'Do you wish to remove this pic?',
          onConfirmed: onConfirmDelete,
        );
      });
}

class DogSmallCard extends StatelessWidget {
  const DogSmallCard({Key key, @required this.dogModel}) : super(key: key);

  final Dog dogModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      width: 150,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: CachedNetworkImage(
          imageUrl: dogModel.picUrl,
          fit: BoxFit.cover,
        ),
        elevation: 4,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
    );
  }
}
