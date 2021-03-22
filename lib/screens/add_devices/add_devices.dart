import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_home/devices/forms/switch_form.dart';
import 'package:auto_home/devices/realtime_device_data.dart';
import 'package:auto_home/models/user.dart';
import 'package:provider/provider.dart';

class AddDevices extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<AddDevices> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    final RealDeviceData realDB = RealDeviceData(uid: user.uid);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                      ),
                      height: 100,
                      child: Center(
                          child: Text(
                            'Devices',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            ),
                          )
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(5, 6, 5, 0),
                      child: ListTile(
                        leading: Icon(
                          Icons.lightbulb_outline_sharp,
                          color: Colors.black87,
                        ),
                        title: Text('Light',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  content: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Light'),
                                      SizedBox(height: 50),
                                      SwitchForm(
                                        realDB: realDB,
                                        type: 'Light',
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(5, 6, 5, 0),
                      child: ListTile(
                        leading: Icon(
                          Icons.swipe,
                          color: Colors.black87,
                        ),
                        title: Text('Switch',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  content: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Switches'),
                                      SizedBox(height: 50),
                                      SwitchForm(
                                        realDB: realDB,
                                        type: 'Switch',
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
