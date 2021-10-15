import 'package:auto_home/devices/device_cards/Device_Card.dart';
import 'package:auto_home/devices/device_cards/Device_Card_Builder.dart';
import 'package:auto_home/devices/switch/light_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RealDeviceData {
  final String uid;
  String hid;
  final realDB = FirebaseDatabase.instance.reference();
  final Function reload;
  CollectionReference user = FirebaseFirestore.instance.collection("Users");

  RealDeviceData({this.reload,this.uid,this.hid});

  Future<bool> loadHID() async {

    try {
      dynamic result = await user.doc(uid).get();
      hid = result.data()['House ID'];
      print('HID Loaded');
      return true;
    } catch (e) {
      return false;
    }
  }

  void createData(String devName) async {
    realDB.child(hid).child(devName).set({'type': 'bool', 'state': 'active'});
  }

  IconData getIcon(String key){
    if(key == "Light") return Icons.wb_incandescent;
    else return Icons.swipe;
  }
  void createSwitch(
      {String switchName,
      String location,
      String state = 'false',
      String type}) async {
    if(hid == null){
      await loadHID();
    }
    print('HID = $hid');
    realDB
        .child(hid)
        .child(type)
        .child(switchName)
        .set({'Location': location, 'State': state});
  }

  Future<bool> removeDevice(DatabaseReference dbr)async{
    try{
      await dbr.remove();
      // reload();
      return true;
    }catch(e){
      print(e.toString());
    }
    return false;
  }

  Future<List<Widget>> loadDevices() async{
    List<Widget> list = [];
    print('Loading Devices');

    realDB.onValue.forEach((element) {
      list.clear();
      print("Data Changed");
      // print('Element :');
      // print('Going through device list');
      Map map = element.snapshot.value[hid];
      // print('Map = $map');
      map.forEach((type, value) {
        Map dev = element.snapshot.value[hid][type];
        // print('Dev Sublist : $dev');
        //  Get Icon
        IconData ico = getIcon(type);
        List<Widget> devList = [];
        dev.forEach((name, stat) {
          // print('$name : ${stat['State']}');
          devList.add(
            DeviceCardBuilder(name: name,type:type,data:stat,removeDevice: removeDevice,dbr: realDB.child(hid).child(type).child(name),)
            );
        });
        list.addAll(devList);

        // list.add(ExpansionTile(
        //   title: Text(key),
        //   children: devList,
        // ));
      });
      print('Returning List');
      return list;
    });
    return list;

  }

}
