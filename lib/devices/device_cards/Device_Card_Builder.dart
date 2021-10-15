import 'package:auto_home/devices/switch/T&H.dart';
import 'package:auto_home/devices/switch/light_card.dart';
import 'package:auto_home/devices/switch/switch_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeviceCardBuilder extends StatefulWidget {
  dynamic data;
  String state;
  String type;
  String name;
  DatabaseReference dbr;
  Function removeDevice;
  DeviceCardBuilder({this.state,this.type,this.data,this.name,this.dbr,this.removeDevice});
  @override
  _DeviceCardBuilderState createState() => _DeviceCardBuilderState();
}

class _DeviceCardBuilderState extends State<DeviceCardBuilder> {
  Map<dynamic,dynamic> res;
  var items = ["ON/OFF","Delete","More"];
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    print('From Inside Device_Card_Builder :');
    print('Type : ${widget.type} (${widget.name})');
    print('Data...');
    print(widget.data.toString());
    //  Here, on the basis of type of device,
    //  We create their respective Card Styles
    if(widget.type == 'Switch'){
      return SwitchCard(name: widget.name,data: widget.data,dbr:widget.dbr,removeDevice: widget.removeDevice
      );
    }else if(widget.type == 'Light'){
      return LightCard(name: widget.name,data: widget.data,dbr:widget.dbr,removeDevice: widget.removeDevice
        );
    }else if(widget.type == 'Sensor'){
      if(widget.name == 'Smoke'){
        return Container(
          color: Colors.white24,
          child: Center(child: Text('Work In Progress'))
        );
      }else if(widget.name == 'T&H'){
        print('T&H State : ${widget.data['State']}');
        return TandH(dbr: widget.dbr,removeDevice: widget.removeDevice,data: widget.data);
      }
    } else{
      //  If Device is not of the recognised type OR there is some fault in data
      return Container(
        color: Colors.black,
        child: Center(
          child: Text(
            "Device Not Recognised",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            )
          ),
        )
      );
    }
  }
}

