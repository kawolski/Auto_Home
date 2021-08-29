import 'package:flutter/material.dart';
import 'package:auto_home/devices/realtime_device_data.dart';
import 'package:auto_home/shared/constants.dart';

class TAndH extends StatefulWidget {
  final RealDeviceData realDB;
  final String type;

  TAndH({this.realDB, this.type});

  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<TAndH> {
  final _formkey = GlobalKey<FormState>();

  String lightName = '';
  String location = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Default: DHT11'),
                validator: (val) => val.isEmpty ? 'Enter Name' : null,
                onChanged: (val) {
                  setState(() {
                    lightName = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Location'),
                validator: (val) => val.isEmpty ? 'Enter Location' : null,
                onChanged: (val) {
                  setState(() {
                    location = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Pin'),
                validator: (val) => val.isEmpty ? 'Enter Pin' : null,
                onChanged: (val) {
                  setState(() {
                    location = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue[600]),
                ),
                child: Text('ADD'),
                onPressed: () {
                  if (_formkey.currentState.validate()) {

                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
