import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  final BuildContext context;

  BaseViewModel({@required this.context});
}
