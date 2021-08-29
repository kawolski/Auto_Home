import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SwitchCard2 extends StatefulWidget {
  String name;
  String state;
  DatabaseReference dbr;
  Function removeDevice;
  IconData icon;
  SwitchCard2({this.icon,this.name,this.state,this.dbr,this.removeDevice});
  @override
  _SwtichCard2State createState() => _SwtichCard2State();
}

class _SwtichCard2State extends State<SwitchCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: widget.state == "true" ? Theme.of(context).focusColor: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: [
          ListTile(

            leading: Icon(
              widget.icon,
              // Icons.add,
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
                child: Text('Remove Device'),
                onPressed: ()async{

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
                                          Theme.of(context).primaryColor),
                                    ),
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      print('Deleting...');
                                      // print('Currently Function is Disabled due to test reasons');
                                      await widget.removeDevice(widget.dbr);
                                      print('Success Removal');
                                    },
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).primaryColor)),
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

                },
              )
            ],
          )
        ],
      ),
    );
  }
}

