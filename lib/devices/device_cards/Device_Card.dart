import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeviceCard extends StatefulWidget {
  String name;
  String state;
  DatabaseReference dbr;
  Function removeDevice;
  IconData icon;
  DeviceCard({this.icon,this.name,this.state,this.dbr,this.removeDevice});
  @override
  _DeviceCardState createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  var items = ["ON/OFF","Delete","More"];
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal:10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black38
        )
      ),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: TextStyle(
              color: Colors.black
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: EdgeInsets.all(5),
              child: DropdownButton(
                items: items.map((String items){
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black87
                ),
                onChanged: (String newValue){
                  setState(() {
                    dropdownValue = newValue;
                    if(dropdownValue == items[0]){
                      //  ON/OFF
                      widget.dbr.update({
                        'State' : widget.state == 'true' ? 'false' : 'true'
                      });
                      widget.state = widget.state == 'true' ? 'false' : 'true';
                    }else if(dropdownValue == items[1]){
                      //  Delete
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
                    }else if(dropdownValue == items[2]){
                      //  More
                    }
                  });
                },
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.state == "true" ? Colors.lightGreenAccent: Colors.redAccent,
          ),
        ),
      ),
    );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(10)),

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

