import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/screens/create_account_screen.dart';
import 'package:doglover/screens/reset_password_screen.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/validator.dart';
import 'package:doglover/viewmodel/login_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:doglover/widgets/dialogs/dl_alert_dialog.dart';
import 'package:doglover/widgets/form_input_card.dart';
import 'package:doglover/widgets/loading_view.dart';
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
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/login_background.jpeg'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 64),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0),
                                child: FormInputCard(
                                  Icons.email,
                                  'Your email',
                                  validation: Validator.emailValidation,
                                  getText: (String value) {
                                    setState(() {
                                      _email = value.trim();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0),
                                child: FormInputCard(
                                  Icons.lock,
                                  'Your password',
                                  isObscured: true,
                                  getText: (String value) {
                                    setState(() {
                                      _password = value.trim();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          color: Styles.mainBackground,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 32.0),
                                  child: RoundedButton(
                                    buttonColor: Styles.eunry,
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        var result = await model.logIn(
                                            _email, _password);
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 32.0),
                                  child: RoundedButton(
                                    buttonColor: Colors.black,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, CreateAccountScreen.id);
                                    },
                                    buttonText: 'SIGN UP',
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, ResetPasswordScreen.id);
                                      },
                                      child: Text(
                                        'Forgot your password?',
                                        style: TextStyle(color: Styles.quincy),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              LoadingView(model.viewState == ViewState.loading)
            ],
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
