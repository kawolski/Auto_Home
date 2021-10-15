import 'package:auto_home/devices/realtime_device_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TandH extends StatefulWidget {
  dynamic data;
  DatabaseReference dbr;
  Function removeDevice;
  TandH({this.data,this.dbr,this.removeDevice});
  @override
  _TandHState createState() => _TandHState();
}

class _TandHState extends State<TandH> {
  var items = ["Delete","More"];
  String dropdownValue;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: widget.dbr.onValue,
      builder: (context, snapshot) {
        widget.dbr.onValue.forEach((element) {
          widget.data = element.snapshot.value;
        });
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
                widget.data['Location'],
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
                    elevation: 2,
                    underline: SizedBox(),
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
                        }else if(dropdownValue == items[1]){
                          //  More
                          /*

                          Code Under Construction

                           */
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
                  color: Colors.white60,
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          Icons.thermostat_rounded,
                          size: 100,
                          color: widget.data['State'] == "true" ? Colors.red[800]: Colors.grey
                      ),
                      Text(
                        widget.data['TempC'],
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w200,
                          color: Colors.black
                        )
                      ),
                      SizedBox(width: 50,),
                      Icon(
                          Icons.grain,
                          size: 40,
                          color: widget.data['State'] == "true" ? Colors.blue[800]: Colors.grey
                      ),
                      Text(
                          widget.data['Humid'],
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.black
                          )
                      )
                    ],
                  ),
                )
            ),
          ),
        );
      }
    );
  }
}
