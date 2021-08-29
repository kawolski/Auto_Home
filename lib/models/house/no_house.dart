import 'package:flutter/material.dart';
import 'package:auto_home/models/house/house.dart';
import 'package:auto_home/models/house/house_auth.dart';
import 'package:auto_home/models/user.dart';
import 'package:auto_home/shared/constants.dart';
import 'package:provider/provider.dart';

class NoHouse extends StatefulWidget {
  @override
  _NoHouseState createState() => _NoHouseState();
}

class _NoHouseState extends State<NoHouse> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context) ??
        UserData(uid: null, userName: null, hid: null);
    String uName = user.userName ?? " ";

    final String message = 'Register Your House';
    final _houseAuth = HouseAuth(uid: user.uid);
    final _formkey = GlobalKey<FormState>();
    String hName = '';
    String hID;

    void loadHouse() async {
      if (hID != null) {
        print('sharing house');
        House result = await _houseAuth.shareHouse(hID);
        print(result);
      } else {
        print("Loading House");
        House result = await _houseAuth.getMyHouse(hName);
        if (result == null) {
          print('Error Loading');
        } else {
          print('Got Results');
          print(result);
        }
      }
    }

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100),
            Center(
              child: ElevatedButton(
                child: Text(message, style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.normal)),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20,vertical: 12)),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ))
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          content: Container(
                            width: MediaQuery.of(context).size.width*0.6,
                            height: MediaQuery.of(context).size.height*0.4,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 2
                              )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Unlock Your Home'),
                                SizedBox(
                                  height: 50,
                                ),
                                Form(
                                  key: _formkey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: textInputDecoration.copyWith(
                                            hintText: 'House Name'),
                                        validator: (val) => val.isEmpty
                                            ? 'Please Enter a Name'
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            hName = val;
                                          });
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      Text("OR"),
                                      SizedBox(height: 20),
                                      TextFormField(
                                        decoration: textInputDecoration.copyWith(
                                            hintText: 'House ID'),
                                        validator: (val) => val.isEmpty
                                            ? 'Please Enter a Name'
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            hID = val;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: MediaQuery.of(context).
                                              size.width*0.2, vertical: 15)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Theme.of(context).primaryColor),
                                        ),
                                        child: Text('Unlock'),
                                        onPressed: () {
                                          // if (_formkey.currentState.validate()) {
                                          loadHouse();
                                          Navigator.pop(context);
                                          // }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
