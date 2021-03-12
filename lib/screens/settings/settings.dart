import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
            ),
            height: 150,
            child: Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30
                  ),
                )
            ),

          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                Card(
                  margin: EdgeInsets.fromLTRB(5, 6, 5, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: Colors.black87,
                    ),
                    title: Text('Profile',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  margin: EdgeInsets.fromLTRB(5, 6, 5, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.house,
                      color: Colors.black87,
                    ),
                    title: Text('House Sharing',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  margin: EdgeInsets.fromLTRB(5, 6, 5, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.add_chart,
                      color: Colors.black87,
                    ),
                    title: Text('About',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}