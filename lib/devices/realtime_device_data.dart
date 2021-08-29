import 'package:auto_home/devices/switch/switch_card_2.dart';
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

  Future<List<Widget>> loadDevices() async{
    List<Widget> list = [];
    print('Loading Devices');

    realDB.onValue.forEach((element) {
      list.clear();
      // print('Going through device list');
      Map map = element.snapshot.value[hid];
      // print('Map = $map');
      map.forEach((key, value) {
        Map dev = element.snapshot.value[hid][key];
        // print('Dev Sublist : $dev');
        //  Get Icon
        IconData ico = getIcon(key);
        List<Widget> devList = [];
        dev.forEach((name, stat) {
          devList.add(
              SwitchCard2(icon: ico,name: name, state: stat['State'],dbr: realDB.child(hid).child(key).child(name),removeDevice: removeDevice,)
          );
        });

        list.add(ExpansionTile(
          title: Text(key),
          children: devList,
        ));
      });
      print('Returning List');
      return list;
    });
    return list;

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

  // List<Widget> loadSwitches() {
  //   List<Widget> list = [];
  //   print('Calling Switches');
  //   realDB.once().then((DataSnapshot snapshot) {
  //     // print('Data : ${snapshot.value}');
  //     // print('Extracting : ${snapshot.value[hid]['Light']}');
  //     // print('HID : $hid');
  //     if(snapshot != null) {
  //       print('Null Snapshot = $snapshot');
  //       Map map = snapshot.value[hid]['Switch'];
  //       // print('List : $map');
  //       print("Play");
  //       map.forEach((name, value) {
  //         list.add(SwitchCard(name: name,
  //             state: value['State'],
  //             dbr: realDB.child(hid).child('Switch').child(name)));
  //         // print('key : $key');
  //         // print('value : $value');
  //         // print('value["State"] : ${value['State']}');
  //       });
  //     }else{
  //       print('Snapshot is Null');
  //     }
  //
  //   });
  //   return list;
  // }

}
