import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_home/devices/switch/switch_card.dart';
import 'package:flutter/material.dart';

class RealDeviceData {
  final String uid;
  final String hid;
  final realDB = FirebaseDatabase.instance.reference();
  CollectionReference user = FirebaseFirestore.instance.collection("Users");

  RealDeviceData({this.uid,this.hid});

  // Future<bool> loadHID() async {
  //   // dynamic result = await user.doc(uid).get();//.data()['House ID'];
  //   try {
  //     dynamic result = await user.doc(uid).get();
  //     hid = result.data()['House ID'];
  //     print('HID Loaded');
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  void createData(String devName) async {
    // dynamic snapshot = await user.doc(uid).get();
    // hid = snapshot.data()['House ID'];
    realDB.child(hid).child(devName).set({'type': 'bool', 'state': 'active'});
  }

  void createSwitch(
      {String switchName,
      String location,
      String state = 'false',
      String type}) async {
    // dynamic snapshot = await user.doc(uid).get();
    // hid = snapshot.data()['House ID'];
    realDB
        .child(hid)
        .child(type)
        .child(switchName)
        .set({'Location': location, 'State': state});
  }

  Future<List<Widget>> loadDevices() async{
    List<Widget> list = [];
    print('Loading Devices');
    // if(hid == null){
    //   await loadHID();
    // }

    await realDB.once().then((DataSnapshot snapshot){
      print('Going through device list');
      Map map = snapshot.value[hid];
      print('Map = $map');
      map.forEach((key, value) {
        Map dev = snapshot.value[hid][key];
        print('Dev Sublist : $dev');
        List<Widget> devList = [];
        dev.forEach((name, stat) {
          devList.add(SwitchCard(name: name, state: stat['State'],dbr: realDB.child(hid).child(key).child(name)));
        });

        list.add(ExpansionTile(
          title: Text(key),
          children: devList,
        ));
      });
    });

    return list;

  }

  Future<List<Widget>> loadLights() async{

    List<Widget> list = [];
    print('Calling Lights');
    // await loadHID();
    realDB.once().then((DataSnapshot snapshot) {

      if(snapshot.value != null){
        print('Null Snapshot = $snapshot');
        Map map = snapshot.value[hid]['Light'];
        print('List : $map');
        print("Play");
        map.forEach((name, value) {
          list.add(SwitchCard(name: name, state: value['State'],dbr: realDB.child(hid).child('Light').child(name),));

          // print('key : $key');
          // print('value : $value');
          // print('value["State"] : ${value['State']}');
        });
        return list;
      }else{
        print('Snapshot is null');
      }
    });
    return list;
  }

  bool removeDevice(String type,String name){
    try{
      realDB.child(hid).child(type).child(name).remove();
      print('Success removal : $name of type $type');
      return true;
    }catch(e){
      print(e.toString());
    }
    return null;
  }


  void toggleSwitch(){
    print("Toggle Pressed");
  }

  List<Widget> loadSwitches() {
    List<Widget> list = [];
    print('Calling Switches');
    realDB.once().then((DataSnapshot snapshot) {
      // print('Data : ${snapshot.value}');
      // print('Extracting : ${snapshot.value[hid]['Light']}');
      // print('HID : $hid');
      if(snapshot != null) {
        print('Null Snapshot = $snapshot');
        Map map = snapshot.value[hid]['Switch'];
        // print('List : $map');
        print("Play");
        map.forEach((name, value) {
          list.add(SwitchCard(name: name,
              state: value['State'],
              dbr: realDB.child(hid).child('Switch').child(name)));
          // print('key : $key');
          // print('value : $value');
          // print('value["State"] : ${value['State']}');
        });
      }else{
        print('Snapshot is Null');
      }

    });
    return list;
  }

}
