import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SwitchCard2 extends StatefulWidget {
  String name;
  String state;
  DatabaseReference dbr;
  Function removeDevice;
  SwitchCard2({this.name,this.state,this.dbr,this.removeDevice});
  @override
  _SwtichCard2State createState() => _SwtichCard2State();
}

class _SwtichCard2State extends State<SwitchCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: [
          ListTile(

            tileColor: Colors.blue[100].withOpacity(0.6),
            leading: Icon(
              Icons.house,
              color: Colors.black87,
            ),
            title: Text(widget.name,
                style: TextStyle(
                  color: Colors.grey,
                )),
            subtitle: Text(
              widget.state
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Text('Toggle'),
                onPressed: (){
                  setState(() {
                    print('Toggle Pressed');
                    widget.dbr.update({
                      'State' : widget.state == 'true' ? 'false' : 'true'
                    });
                  });
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: ()async{
                  print('Deleting...');
                  print('Currently Function is Disabled due to test reasons');
                  // await widget.removeDevice(widget.dbr);
                  // print('Success Removal');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

