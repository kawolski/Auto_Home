import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_home/screens/home/home.dart';
import 'package:auto_home/screens/authenticate/authenticate.dart';
import 'package:auto_home/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
