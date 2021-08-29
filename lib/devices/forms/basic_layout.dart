import 'package:flutter/material.dart';

class FormLayout extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final List widgetList;
  FormLayout({this.widgetList});
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: widgetList,
      ),
    );
  }
}
