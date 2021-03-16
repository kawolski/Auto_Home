import 'package:auto_home/devices/forms/switch_form.dart';
import 'package:auto_home/devices/realtime_device_data.dart';
import 'package:flutter/material.dart';

class DevContainer extends StatelessWidget {
  final RealDeviceData realDB;

  DevContainer({this.realDB});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 50),
          color: Colors.yellowAccent.withOpacity(0.5),
          child: TextButton.icon(
            icon: Icon(Icons.lightbulb_outline_sharp, size: 50),
            label: Text("Light"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          )),
    );
  }
}
