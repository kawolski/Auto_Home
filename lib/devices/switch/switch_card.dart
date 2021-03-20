import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SwitchCard extends StatefulWidget {
  final String name;
  final String state;
  final DatabaseReference dbr;
  SwitchCard({this.name, this.state,this.dbr});

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<SwitchCard> {
  String inState;
  @override
  Widget build(BuildContext context) {
    inState =  inState == null ? widget.state : inState;
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
              subtitle: Text(inState),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                  onPressed: (){
                    String newState = inState == 'true' ? 'false' : 'true';
                    setState(() {
                      print('Toggle Pressed');
                      widget.dbr.update({
                        'State' : newState
                      });
                      inState = newState;
                    });
                    print('Instate : $inState');
                    print('New State : $newState');
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
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white70,
                ),
                onPressed: (){
                  print('Pressed');
                },
              ),
            ]
          ),
        ],
      ),
    );
  }
}
