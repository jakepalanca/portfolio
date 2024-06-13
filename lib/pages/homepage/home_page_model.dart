import 'package:flutter/material.dart';

class HomePageModel extends ChangeNotifier {
  final unfocusNode = FocusNode();

  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    super.dispose();
  }
}
