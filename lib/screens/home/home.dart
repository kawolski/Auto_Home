import 'package:auto_home/screens/home/header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_home/models/user.dart';
import 'package:auto_home/screens/add_devices/add_devices.dart';
import 'package:auto_home/screens/home/drawer_tile.dart';
import 'package:auto_home/screens/home/select.dart';
import 'package:auto_home/screens/settings/settings.dart';
import 'package:auto_home/services/auth.dart';
import 'package:auto_home/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: Text(
                'Reload',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  print('Reloaded');
                });
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                        ),
                        height: 200,
                        child: Center(
                            child: Header(uid: user.uid)
                        ),
                      ),
                      // Container(
                      //   color: Colors.yellowAccent.withOpacity(0.6),
                      //   height: MediaQuery.of(context).size.height * 1,
                      // ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: Select()
                      )
                    ],
                  )
                )
              )
            ),

          ],
        ),
        drawer: Drawer(
          elevation: 1,
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.lightBlue),
                child: Column(children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/stock_profile.png'),
                  ),
                ]),
              ),
              //  Add New Device
              DrawerTile(
                  icon: Icons.add,
                  text: "Add New Device",
                  function: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddDevices()));
                  }),
              //  Settings
              DrawerTile(
                  icon: Icons.settings,
                  text: "Settings",
                  function: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  }),
              //  Logout
              DrawerTile(
                  icon: Icons.perm_identity_rounded,
                  text: "Leave",
                  function: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("Are You Sure"),
                                SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    TextButton(
                                      // padding:EdgeInsets.symmetric(horizontal:20),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black54),
                                      ),
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await _auth.signOut();
                                      },
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black54)),
                                      child: Text(
                                        "No",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
