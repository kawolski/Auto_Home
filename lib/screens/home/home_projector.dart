import 'package:auto_home/shared/Inloading.dart';
import 'package:auto_home/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:auto_home/devices/realtime_device_data.dart';
import 'package:provider/provider.dart';
import 'package:auto_home/models/user.dart';

class HomeProjector extends StatefulWidget {
  final String hid;
  HomeProjector({this.hid});
  @override
  _HomeProjectorState createState() => _HomeProjectorState();
}

class _HomeProjectorState extends State<HomeProjector> {

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final RealDeviceData realDB = RealDeviceData(uid: userData.uid,hid: widget.hid,reload: (){setState(() {

    });});

    return FutureBuilder(
      initialData: [InLoading()],
      future: realDB.loadDevices(),
      builder: (context,builderSnapshot){

        if(builderSnapshot.connectionState == ConnectionState.done){
          return StreamBuilder(
            stream: realDB.realDB.onValue,
            builder: (context,snapshot){
              print('Stream Snapshot : ${builderSnapshot.data}');
              return Column(
                children: builderSnapshot.data,
              );
            },
          );
        }else{
          return InLoading();
        }
    },
    );
  }
}
