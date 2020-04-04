import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/validator.dart';
import 'package:doglover/viewmodel/reset_password_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:doglover/widgets/dialogs/dl_alert_dialog.dart';
import 'package:doglover/widgets/form_input_card.dart';
import 'package:doglover/widgets/loading_view.dart';
import 'package:doglover/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password_screen';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ResetPasswordViewModel>(
      model: ResetPasswordViewModel(context),
      builder: (ResetPasswordViewModel model) {
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
                                  'Your email',
                                  validation: Validator.emailValidation,
                                  getText: (String value) {
                                    setState(() {
                                      _email = value.trim();
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
                                var result = await model.reset(_email);
                                switch (result) {
                                  case ResetPasswordResult.success:
                                    showPasswordResetSuccessDialog(context);
                                    break;
                                  case ResetPasswordResult.failure:
                                    showResetFailedDialog(
                                        context, 'Password reset failed');
                                    break;
                                  case ResetPasswordResult.email_not_found:
                                    showResetFailedDialog(context,
                                        'User with this email doesn\'t exist');
                                    break;
                                }
                              }
                            },
                            buttonText: 'RESET',
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

  void showResetFailedDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return DLAlertDialog(
            title: 'Reset Password Failed',
            text: message,
            onConfirmed: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  void showPasswordResetSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return DLAlertDialog(
            title: 'Password Reset',
            text: 'Check you email for instructions how to reset your password',
            onConfirmed: () {
              Navigator.of(context).pop();
            },
          );
        });
  }
}
