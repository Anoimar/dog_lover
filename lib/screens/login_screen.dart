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
  String _email;
  String _password;

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
                            FormInputCard(
                              Icons.person,
                              'Your email',
                              validation: (email) {
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email)) {
                                  return 'Email not correct';
                                }
                                return null;
                              },
                              getText: (String value) {
                                setState(() {
                                  _email = value.trim();
                                });
                              },
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            FormInputCard(
                              Icons.lock,
                              'Your password',
                              isObscured: true,
                              getText: (String value) {
                                setState(() {
                                  _password = value.trim();
                                });
                              },
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
                            _formKey.currentState.save();
                            var result = await model.logIn(_email, _password);
                            switch (result) {
                              case LoginResult.success:
                                Navigator.pop(context);
                                break;
                              case LoginResult.failure:
                                showFailedLoginDialog(
                                    context, 'Failed to login');
                                break;
                              case LoginResult.user_not_found:
                                showFailedLoginDialog(
                                    context, 'User doesn\'t exist');
                                break;
                              case LoginResult.wrong_password:
                                showFailedLoginDialog(
                                    context, 'Password is wrong');
                                break;
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

  void showFailedLoginDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return DLAlertDialog(
            title: 'Login failed',
            text: message,
            onConfirmed: () {
              Navigator.of(context).pop();
            },
          );
        });
  }
}

class DLAlertDialog extends StatelessWidget {
  final String title;
  final String text;
  final Function onConfirmed;

  const DLAlertDialog({this.title, this.text, this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: <Widget>[
        FlatButton(
          onPressed: onConfirmed,
          child: Text('OK'),
        )
      ],
    );
  }
}
