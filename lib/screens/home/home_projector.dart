import 'package:auto_home/shared/Inloading.dart';
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
    // List<Widget> lightList = realDB.loadLights();
    // while(lightList.isEmpty){
    //   return Container();
    // }

    return FutureBuilder(
      future: realDB.loadDevices(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return Column(
              children: snapshot.data
          );
        }else{
          return InLoading();
        }
    },
    );
    // return StreamProvider.value(
    //   value: realDB.realDB.onValue,
    //   child: ListView(
    //     shrinkWrap: true,
    //     children: <Widget>[
    //       ExpansionTile(
    //         title: Text('Lights'),
    //         children: realDB.loadLights(),
    //       ),
    //       // ExpansionTile(
    //       //   title: Text('Switches'),
    //       //   children: realDB.loadSwitches(),
    //       // )
    //     ],
    //   ),
    // );
  }
}
