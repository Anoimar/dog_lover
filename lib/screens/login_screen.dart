import 'package:doglover/data/source/login_result.dart';
import 'package:doglover/screens/create_account_screen.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/viewmodel/login_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:doglover/widgets/form_input_card.dart';
import 'package:doglover/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>(
      model: LoginViewModel(context),
      builder: (LoginViewModel model) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBarBuilder.createTransparentAppBar(),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/login_background.jpeg'),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 64),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FormInputCard(Icons.person, 'Your email'),
                            SizedBox(
                              height: 12.0,
                            ),
                            FormInputCard(
                              Icons.lock,
                              'Your password',
                              isObscured: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: RoundedButton(
                        buttonColor: Styles.eunry,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var result = await model.logIn();
                            if (result == LoginResult.success) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        buttonText: 'LOG  IN',
                      ),
                    ),
                    RoundedButton(
                      buttonColor: Colors.black,
                      onPressed: () {
                        Navigator.pushNamed(context, CreateAccountScreen.id);
                      },
                      buttonText: 'SIGN UP',
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
