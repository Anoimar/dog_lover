import 'package:doglover/viewmodel/info_screen.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class InfoScreen extends StatelessWidget {
  static const String id = 'info_screen';

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InfoViewModel>(
      model: InfoViewModel(context),
      builder: (InfoViewModel model) {
        return Scaffold(
          backgroundColor: Styles.mainBackground,
          appBar: AppBarBuilder.createTransparentAppBar(),
          extendBodyBehindAppBar: true,
          body: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/dogs.jpg"),
                  Text('About Dog Lover App',
                      style: kMediumLabelStyle.copyWith(fontSize: 24)),
                ],
              ),
              Text('Lore'),
            ],
          ),
        );
      },
    );
  }
}
