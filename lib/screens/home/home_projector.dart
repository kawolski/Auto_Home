import 'package:auto_home/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:auto_home/devices/realtime_device_data.dart';
import 'package:provider/provider.dart';
import 'package:auto_home/models/user.dart';

class HomeProjector extends StatefulWidget {
  @override
  _HomeProjectorState createState() => _HomeProjectorState();
}

class _HomeProjectorState extends State<HomeProjector> {

  String status = 'House Found';

  void test(bool b) {}

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final RealDeviceData realDB = RealDeviceData(uid: userData.uid);
    realDB.loadHID();

    return StreamProvider.value(
      value: realDB.realDB.onValue,
      child: ListView(
        children: <Widget>[
          ExpansionTile(
            maintainState: true,
            title: Text('Lights'),
            children: realDB.loadLights(),
          ),
          ExpansionTile(
            maintainState: true,
            title: Text('Switches'),
            children: realDB.loadSwitches(),
          )
        ],
      ),
    );
    // return StreamBuilder(
    //   stream: realDB.realDB.onValue,
    //   builder: (context,snapshot){
    //     if(snapshot.hasData){
    //       print("Snapshot Data : $snapshot");
    //       // print(snapshot);
    //       return ListView(
    //         children: <Widget>[
    //           ExpansionTile(
    //             maintainState: true,
    //             title: Text('Lights'),
    //             children: realDB.loadLights()
    //           ),
    //           ExpansionTile(
    //               maintainState: true,
    //               title: Text('Switches'),
    //               children: realDB.loadSwitches()
    //           )
    //         ],
    //       );
    //     }else{
    //       print("No Data");
    //       return Loading();
    //     }
    //   },
    // );
  }
}
