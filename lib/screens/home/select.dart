import 'package:auto_home/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:auto_home/models/house/no_house.dart';
import 'package:auto_home/models/user.dart';
import 'package:auto_home/screens/home/home_projector.dart';
import 'package:provider/provider.dart';

class Select extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context) ??
        UserData(uid: null, userName: null, hid: null);
    if (userData.hid == null) {
      return NoHouse();
    } else {
      return HomeProjector(hid: userData.hid,);
    }
  }
}
