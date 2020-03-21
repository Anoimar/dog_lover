import 'package:doglover/styles.dart';
import 'package:doglover/viewmodel/login_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:doglover/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>(
      model: LoginViewModel(context),
      builder: (LoginViewModel model) {
        return Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: RoundedButton(
                      buttonColor: Styles.eunry,
                      onPressed: () {},
                      buttonText: 'LOGIN',
                    ),
                  ),
                  RoundedButton(
                    buttonColor: Styles.buttonColor,
                    onPressed: () {},
                    buttonText: 'SIGN UP',
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
