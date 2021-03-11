import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SwitchCard extends StatefulWidget {
  final String name;
  String state;
  final DatabaseReference dbr;
  SwitchCard({this.name, this.state,this.dbr});

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<SwitchCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/stock_profile.png'),
              ),
              title: Text(widget.name),
              subtitle: Text(widget.state),
            ),
          ),
          TextButton.icon(
              onPressed: (){
                String newState = widget.state == 'true' ? 'false' : 'true';
                setState(() {
                    print('Toggle Pressed');
                    widget.dbr.update({
                      'State' : newState
                    });
                    widget.state = newState;
                });
              },
              icon: Icon(
                Icons.wb_shade,
                color: Colors.white,
              ),
              label: Text(
                "Toggle",
                style: TextStyle(
                  color: Colors.white
                ),
              )
          )
        ],
      ),
    );
  }
}
