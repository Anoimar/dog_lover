import 'package:doglover/viewmodel/add_dog_pic_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:doglover/widgets/form_input_card.dart';
import 'package:doglover/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdi/mdi.dart';

import '../styles.dart';

class AddDogPicScreen extends StatefulWidget {
  static const String id = 'add_dog_pic_screen';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final passKey = GlobalKey<FormFieldState>();

  @override
  _AddDogPicScreenState createState() => _AddDogPicScreenState();
}

class _AddDogPicScreenState extends State<AddDogPicScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  String _breed;
  String _description;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AddDogPicViewModel>(
        model: AddDogPicViewModel(context),
        builder: (AddDogPicViewModel model) {
          double bottom = MediaQuery.of(context).viewInsets.bottom;
          return Scaffold(
            backgroundColor: Styles.mainBackground,
            resizeToAvoidBottomInset: false,
            appBar: AppBarBuilder.createTransparentAppBar(),
            extendBodyBehindAppBar: true,
            body: SafeArea(
              child: LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottom),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                          maxHeight: viewportConstraints.maxHeight),
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            flex: 4,
                            child: Stack(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      width: 300,
                                      child: Card(
                                        elevation: 4,
                                        child: model.dogPic != null
                                            ? Image.file(model.dogPic,
                                                fit: BoxFit.cover)
                                            : Image(
                                                image: AssetImage(
                                                  'assets/lola_adult.jpg',
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: RoundedButton(
                                    buttonColor: Styles.eunry,
                                    onPressed: () async {
                                      var image = await ImagePicker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 10);
                                      model.imagePicked(image);
                                    },
                                    buttonText: 'SELECT PIC',
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Flexible(
                            flex: 6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Form(
                                  key: _formKey,
                                  child: Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            FormInputCard(
                                              Mdi.formatTitle,
                                              'Picture name',
                                              getText: (String value) {
                                                setState(() {
                                                  _name = value.trim();
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: 12.0,
                                            ),
                                            FormInputCard(
                                              Mdi.dog,
                                              'Your dog breed (optional)',
                                              allowEmpty: true,
                                              getText: (String value) {
                                                setState(() {
                                                  _breed = value.trim();
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: 12.0,
                                            ),
                                            FormInputCard(
                                              Icons.description,
                                              'Description (optional)',
                                              allowEmpty: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: RoundedButton(
                                                buttonColor: Styles.quincy,
                                                onPressed: () {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    _formKey.currentState
                                                        .save();
                                                  }
                                                  if (model.dogPic != null &&
                                                      _name != null) {
                                                    print("Filled");
                                                  } else {}
                                                },
                                                buttonText: 'UPLOAD PICTURE',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        });
  }
}
