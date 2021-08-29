import 'package:auto_home/models/house/house.dart';
import 'package:auto_home/models/user.dart';
import 'package:auto_home/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  final String uid;
  Header({this.uid});
  @override
  Widget build(BuildContext context) {

    final data = Provider.of<UserData>(context) ?? UserData(houseName: "...LOADING...");

    String stat = data.houseName ?? null;

    if(stat == null){
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color : Colors.white.withOpacity(0.7),
          backgroundBlendMode: BlendMode.screen,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          "Hi, ${data.userName}\nLet's get Started",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black87,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
      );
    }else{
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color : Colors.white.withOpacity(0.7),
            backgroundBlendMode: BlendMode.screen,
            borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          stat,
          style: TextStyle(
              color: Colors.black45,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
      );
    }

  }
}
