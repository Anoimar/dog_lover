import 'package:cached_network_image/cached_network_image.dart';
import 'package:doglover/styles.dart';
import 'package:doglover/viewmodel/account_view_model.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:flutter/material.dart';

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
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: CachedNetworkImageProvider(
                            'https://avatars1.githubusercontent.com/u/7840940?s=460&u=4565e4387d89c3924619ee29edad18e84099557e&v=4'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          model.name,
                          style: kMediumLabelStyle.copyWith(
                              color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Text(model.email),
                      Text('My dogs')
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
