import 'package:auto_home/models/user.dart';
import 'package:auto_home/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  final String uid;
  Header({this.uid});
  @override
  Widget build(BuildContext context) {

    final data = Provider.of<UserData>(context);

    String stat = data.houseName ?? null;

    if(stat == null){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hi,',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  '${data.userName}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Text(
              'Lets Get Started',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
          ],
        ),
      );
    }else{
      return Container(
        child: Text(
          stat,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
      );
    }

  }
}
