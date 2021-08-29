import 'package:flutter/material.dart';
import 'package:auto_home/services/auth.dart';
import 'package:auto_home/shared/loading.dart';
import 'package:auto_home/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  bool loading = false;

  final _formkey = GlobalKey<FormState>();

  String email;
  String password;
  String error = '';
  String userName;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Enter Your Name'),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter Your Name';
                        } else if (val.length < 5) {
                          return 'Name shall be greater than 5 letters';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          userName = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val.isEmpty ? 'Please Enter an Email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                        obscureText: true,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val.length < 6
                            ? 'Password length should be greater than 6'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        }),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                      ),
                      child: Text('REGISTER'),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        print("$email...");
                        email = email.replaceAll(" ", "");
                        print("$email...");
                        if (_formkey.currentState.validate()) {
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  userName, email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Email not Valid. Please Supply Valid Email';
                              loading = false;
                            });
                          }
                        }
                        else{
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      error,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
