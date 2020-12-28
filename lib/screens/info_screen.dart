import 'package:doglover/constants.dart';
import 'package:doglover/viewmodel/info_screen.dart';
import 'package:doglover/viewmodel/view_model_provider.dart';
import 'package:doglover/widgets/appbar/app_bar_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      style: kMediumLabelStyle.copyWith(
                          fontSize: 24, color: Colors.white)),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InfoParagraph(
                          title: 'What is Dog Lover App?',
                          content: Text(
                              'Its a simple app allowing users(actually me ;) ) to check data about dog breeds and create a list of favourite dog breeds'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InfoParagraph(
                          title: 'Other Features',
                          content: Text(
                              'There are some other social app functions like sharing dog pictures for registered users but because such features demand full an active support which a hobby app like this won\'t have, don\'t expect after logging seeing anything else than pictures of dogs provided by me and my friends. '
                              'However if you wish to see your dog pics in the app you can mail it to me I add them to the app. Or maybe you wish to host such app yourself. You can find the code for iOS and Android app and its backend on my github.'),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InfoParagraph(
                            title: 'Credits',
                            content: Text(
                                '1. Aden Forshaw and his team from https://www.thatapicompany.com . '
                                'Its amazing how many people thanks to their work learned something new. I don\'t believe  I would create a pretty big flutter '
                                'app if I didn\'t have a fun api to work with.\n'
                                '2. My friends, colleagues and relatives  for providing me materials that I could use in the app.'),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 32.0),
                        child: InfoParagraph(
                          title: 'Contact Me',
                          content: SelectableLinkify(
                            onOpen: (link) => parseLink(link.text),
                            text:
                                'My mail $kMyEmail\n\nApp code: $kAppCode\n\n Backend code: $kBECode',
                          ),
                        ),
                      )
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

Future<void> parseLink(String link) async {
  if (link.contains('webservices')) {
    await launch(kBECode);
  } else if (link.endsWith('lover')) {
    await launch(kAppCode);
  } else {
    await launch('mailto:$kMyEmail');
  }
}

class InfoParagraph extends StatelessWidget {
  final String title;

  final Widget content;

  const InfoParagraph({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: kMediumLabelStyle),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: content,
        ),
      ],
    );
  }
}
