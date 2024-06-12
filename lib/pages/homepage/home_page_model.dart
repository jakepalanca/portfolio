import 'package:flutter/material.dart';

class HomePageModel extends ChangeNotifier {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    super.dispose();
  }
}
