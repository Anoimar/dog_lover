import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/screens/login_screen.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/validator.dart';
import 'package:doglover/viewmodel/create_account_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:doglover/widgets/dialogs/dl_alert_dialog.dart';
import 'package:doglover/widgets/form_input_card.dart';
import 'package:doglover/widgets/loading_view.dart';
import 'package:doglover/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String id = 'create_account_screen';

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final passKey = GlobalKey<FormFieldState>();

  String _email;
  String _password;
  String _name;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreateAccountViewModel>(
      model: CreateAccountViewModel(context),
      builder: (CreateAccountViewModel model) {
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
                                  'Your name',
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
                                  Icons.mail,
                                  'Your email',
                                  validation: Validator.emailValidation,
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
                                  fieldKey: passKey,
                                  getText: (String value) {
                                    setState(() {
                                      _password = value.trim();
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                FormInputCard(
                                  Icons.lock,
                                  'Retype password',
                                  isObscured: true,
                                  validation: (text) {
                                    var password = passKey.currentState.value;
                                    return text == password
                                        ? null
                                        : "Password doesn\'t match";
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
                                var result = await model.signUp(
                                    _email, _password, _name);
                                switch (result) {
                                  case SignUpResult.success:
                                    showCreateAccountSuccessDialog(context);
                                    break;
                                  case SignUpResult.failure:
                                    showSignUpFailedDialog(context,
                                        'We couldn\'t create account for you. Try again later or contact our support');
                                    break;
                                  case SignUpResult.password_insufficient:
                                    showSignUpFailedDialog(context,
                                        'Your password seems too weak. Try something longer and more difficult to guess');
                                    break;
                                  case SignUpResult.user_exist:
                                    showSignUpFailedDialog(context,
                                        'The user with this email is already registered.');
                                    break;
                                }
                              }
                            },
                            buttonText: 'REGISTER',
                          ),
                        ),
                      ],
                    ),
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

  void showSignUpFailedDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return DLAlertDialog(
            title: 'Sign Up Failed',
            text: message,
            onConfirmed: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  void showCreateAccountSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return DLAlertDialog(
            title: 'Account created',
            text: 'You can now log in with your new account!',
            onConfirmed: () {
              Navigator.popUntil(context, ModalRoute.withName(LoginScreen.id));
            },
          );
        });
  }
}
