import 'package:doglover/viewmodel/account_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AccountViewModel>(
      model: AccountViewModel(context),
      builder: (AccountViewModel model) {
        return Scaffold(
          body: Container(
            child: Center(
              child: Text('Account'),
            ),
          ),
        );
      },
    );
  }
}
