import 'package:doglover/viewmodel/login_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>(
      model: LoginViewModel(context),
      builder: (LoginViewModel model) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/login_background.jpeg'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                TextField(),
                TextField(),
                RaisedButton(
                  child: Text('LOGIN'),
                ),
                RaisedButton(
                  child: Text('SIGN UP'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
